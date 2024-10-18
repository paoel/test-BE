const express = require('express');
const bodyParser = require('body-parser');
const pungutanRoutes = require('./routes/pungutanRoutes');
const app = express();

app.use(bodyParser.json());

app.use(pungutanRoutes);

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
