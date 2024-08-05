import express from 'express';
import bodyParser from 'body-parser';
import sqlite3 from 'sqlite3';
import path from 'path';
import { fileURLToPath } from 'url';

const app = express();
const db = new sqlite3.Database(':memory:');

// Create table
db.serialize(() => {
    db.run('CREATE TABLE data (id INTEGER PRIMARY KEY AUTOINCREMENT, data TEXT)');
});

app.use(bodyParser.urlencoded({ extended: false }));

// Convert import.meta.url to __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.post('/submit', (req, res) => {
    const data = req.body.data;
    db.run('INSERT INTO data (data) VALUES (?)', [data], function(err) {
        if (err) {
            return res.status(500).json({ message: 'Error storing data' });
        }
        res.json({ message: 'Data received' });
    });
});

const PORT = 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
