const express = require('express');
const axios = require('axios');
const fs = require('fs');
const { getDataFromDatabase } = require('./db');
require('dotenv').config();
const { OllamaEmbeddings } = require("@langchain/community/embeddings/ollama");
const keywordExtractor = require('keyword-extractor');
const path = require('path');
const app = express();
//const FormData = require('form-data');
const { google } = require('googleapis');

app.use(express.json());

let embeddingsData = []; // Mảng lưu embeddings từ tệp JSON
app.use(express.static(path.join(__dirname, 'public')));

// Add route for HTML page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});
// Hàm tạo embedding
async function createEmbedding(text) {
    try {
        const embeddings = new OllamaEmbeddings({
            model: "nomic-embed-text",
            baseUrl: "http://localhost:11434"
        });
        const result = await embeddings.embedQuery(text);
        return Array.isArray(result) ? result : [];
    } catch (error) {
        console.error("Ollama embedding error:", error);
        throw new Error(`Embedding generation failed: ${error.message}`);
    }
}

// Lưu dữ liệu vào tệp JSON
async function saveDataToJSON(data) {
    try {
        fs.writeFileSync('embeddings.json', JSON.stringify(data, null, 2));
        console.log('Data saved to embeddings.json');
    } catch (error) {
        console.error('Error saving data to JSON:', error);
        throw error;
    }
}

// Đưa dữ liệu vào tệp JSON
async function upsertDataToJSON(data) {
    try {
        const vectors = await Promise.all(
            data.map(async (doc) => ({
                id: doc.id.toString(),
                values: await createEmbedding(doc.text),
                metadata: { text: doc.text }
            }))
        );

        embeddingsData = vectors; // Cập nhật dữ liệu trong bộ nhớ
        await saveDataToJSON(vectors); // Lưu vào tệp JSON
        console.log('Data has been saved to JSON');
    } catch (error) {
        console.error('Upsert error:', error);
        throw error;
    }
}

// Truy vấn dữ liệu từ tệp JSON (giả lập tìm kiếm)
async function queryDataFromJSON(queryEmbedding) {
    // Giả lập tìm kiếm dữ liệu dựa trên độ tương đồng cosine (sử dụng vector queryEmbedding)
    // Trong ví dụ này, chúng ta chỉ lấy top 5 kết quả gần nhất.
    return embeddingsData.slice(0, 30).map((item) => item.metadata.text);
}
// async function generateImage(prompt) {
//     try {
//         const formData = new FormData();
//         formData.append('prompt', prompt);
//         formData.append('output_format', 'webp');

//         const response = await axios.post(
//             'https://api.stability.ai/v2beta/stable-image/generate/ultra',
//             formData,
//             {
//                 headers: {
//                     'Accept': 'image/*',
//                     'Authorization': `Bearer ${process.env.STABILITY_API_KEY}`
//                 },
//                 responseType: 'arraybuffer'
//             }
//         );

//         const base64Image = Buffer.from(response.data).toString('base64');
//         return `data:image/webp;base64,${base64Image}`;
//     } catch (error) {
//         if (error.response) {
//             console.error(`Error: ${error.response.status} - ${error.response.data}`);
//         } else {
//             console.error('Error:', error.message);
//         }
//         return null;
//     }
// }
async function fetchImage(prompt) {
    const customsearch = google.customsearch('v1');
    const API_KEY = process.env.GG_SEARCH_API_KEY; // Thay bằng API Key của bạn
    const CX = process.env.GG_SEARCH_CX;   // Thay bằng Search Engine ID của bạn

    try {
        // Gửi yêu cầu tìm kiếm hình ảnh
        const response = await customsearch.cse.list({
            auth: API_KEY,
            cx: CX,
            q: prompt,
            searchType: 'image',
            num: 1, // Số lượng hình ảnh muốn lấy
        });

        if (response.data.items && response.data.items.length > 0) {
            // Lấy URL của hình ảnh đầu tiên
            const imageUrl = response.data.items[0].link;

            // Tải hình ảnh về dưới dạng base64
            const imageResponse = await axios.get(imageUrl, { responseType: 'arraybuffer' });
            const base64Image = Buffer.from(imageResponse.data).toString('base64');
            return `data:image/jpeg;base64,${base64Image}`; // Định dạng hình ảnh (jpeg, png, ...)
        } else {
            console.error('No images found for the given prompt.');
            return null;
        }
    } catch (error) {
        console.error('Error fetching image:', error.message);
        return null;
    }
}

// Ví dụ sử dụng

async function generateAnswer(context, question) {
    try {
        const prompt = `Answer the question based only on the following context:\n\n${context}\n\nQuestion: ${question}`;
        const response = await axios.post(
            'https://api.groq.com/openai/v1/chat/completions',
            {
                model: 'llama3-8b-8192',
                messages: [{ role: 'user', content: prompt }],
                temperature: 0.2,
            },
            { headers: { Authorization: `Bearer ${process.env.GROQ_API_KEY}` } }
        );
        return response.data.choices[0].message.content.trim();
    } catch (error) {
        console.error('Error generating answer:', error.response?.data || error.message);
        throw new Error('Failed to generate answer.');
    }
}

// API để xử lý câu hỏi
// app.post('/ask', async (req, res) => {
//     const { question } = req.body;

//     try {
//         // Tạo embedding cho câu hỏi
//         const questionEmbedding = await createEmbedding(question);

//         // Truy vấn dữ liệu từ tệp JSON
//         const relevantDocs = await queryDataFromJSON(questionEmbedding);

//         // Kết hợp nội dung từ các tài liệu
//         const context = relevantDocs.join('\n');

//         // Sinh câu trả lời
//         const answer = await generateAnswer(context, question);

//         res.json({ answer });
//     } catch (error) {
//         console.error(error);
//         res.status(500).json({ error: 'Something went wrong' });
//     }
// });

app.post('/ask', async (req, res) => {
    const { question } = req.body;

    try {
        const questionEmbedding = await createEmbedding(question);
        const relevantDocs = await queryDataFromJSON(questionEmbedding);
        const context = relevantDocs.join('\n');
        const answer = await generateAnswer(context, question);
            

        
        // try {
           
        //    imageBase64 = await fetchImage('beautiful landscape')
        // } catch (imageError) {
        //     console.error('Image generation failed:', imageError);
        //     // Continue without image if generation fails
        // }

        res.json({ 
            answer,
         //   image: imageBase64 ,
            
        });
    } catch (error) {
        console.error('Error processing request:', error);
        res.status(500).json({ 
            error: 'An error occurred while processing your request',
            details: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
});

// Khởi tạo và tải dữ liệu vào JSON
(async () => {
    try {
        const data = await getDataFromDatabase();
        const dataWithText = data.map(product => {
            const text = `${product.name}: ${product.description}, giá ${product.price} VND, còn lại ${product.stock} cái trong kho.`;
            return { id: product.id, text }; // Lưu trữ text để tạo embeddings
        });

        await upsertDataToJSON(dataWithText);

        console.log('Data has been loaded into JSON');
    } catch (error) {
        console.error('Error initializing data:', error);
    }
})();

// Chạy server
app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
