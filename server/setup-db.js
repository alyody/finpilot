#!/usr/bin/env node

import { PrismaClient } from '@prisma/client';
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

async function setupDatabase() {
    console.log('🔄 Starting database setup...');
    
    const maxRetries = 5;
    let attempt = 0;
    
    while (attempt < maxRetries) {
        try {
            console.log(`📡 Attempt ${attempt + 1}/${maxRetries}: Testing database connection...`);
            
            const prisma = new PrismaClient();
            await prisma.$connect();
            console.log('✅ Database connection successful!');
            
            console.log('🔄 Running database migrations...');
            await execAsync('npx prisma db push');
            console.log('✅ Database migrations completed!');
            
            await prisma.$disconnect();
            console.log('🎉 Database setup completed successfully!');
            process.exit(0);
            
        } catch (error) {
            attempt++;
            console.log(`❌ Attempt ${attempt} failed:`, error.message);
            
            if (attempt < maxRetries) {
                const delaySeconds = attempt * 2;
                console.log(`⏳ Waiting ${delaySeconds} seconds before retry...`);
                await delay(delaySeconds * 1000);
            } else {
                console.log('🚨 All connection attempts failed. Skipping database setup for now.');
                console.log('💡 The server will start, but you may need to run database setup manually.');
                process.exit(0); // Exit with success to allow deployment to continue
            }
        }
    }
}

setupDatabase().catch((error) => {
    console.error('🚨 Database setup failed:', error);
    process.exit(0); // Exit with success to allow deployment to continue
});