const { Pinecone } = require('@pinecone-database/pinecone');
require('dotenv').config();

const pinecone = new Pinecone({
    apiKey: process.env.PINECONE_API_KEY,
});

async function initPinecone() {
    try {
        const index = pinecone.index('quickstart');
        // Test connection
        await index.describeIndexStats();
        return index;
    } catch (error) {
        console.error('Error initializing Pinecone:', error);
        throw error;
    }
}

// Helper function to validate vector format
async function upsertVectors(index, vectors) {
    if (!Array.isArray(vectors)) {
        throw new Error('Vectors must be an array');
    }
    
    vectors.forEach(vector => {
        if (!vector.id || !Array.isArray(vector.values)) {
            throw new Error('Each vector must have an "id" and "values" array');
        }
        if (vector.values.length !== VECTOR_DIMENSION) {
            throw new Error(`Vector dimension ${vector.values.length} does not match required dimension ${VECTOR_DIMENSION}`);
        }
    });

    return await index.upsert(vectors);
}


module.exports = { initPinecone, upsertVectors };