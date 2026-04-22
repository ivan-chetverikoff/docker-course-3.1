const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;
const MSG = process.env.APP_MESSAGE || ' Hello from Docker!';
app.get('/', (req, res) => res.send(`<h1>${MSG}</h1>`));
app.listen(PORT, '0.0.0.0', () => console.log(`Server on :${PORT}`));
