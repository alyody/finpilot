import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { PrismaClient } from '@prisma/client';
import routes from './index.js';

const prisma = new PrismaClient();
dotenv.config({ path: './.env' });

const app = express();
const port = process.env.PORT || 5000;  // ← Make sure this line exists

app.use(express.json());
app.use(cors());

// App Routes
app.use('/', routes);

app.get('/', (req, res) => {
    res.send('Hello, Welcome to FinPilot API! 🚀');
});

// Getting users
app.get('/users', async (req, res) => {
    try {
        const users = await prisma.user.findMany();
        res.json(users);
    } catch (error) {
        console.error('Error fetching users:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

app.listen(port, '0.0.0.0', () => {  // ← Added '0.0.0.0' binding
    console.log(`Server is running on port ${port}`);
});
