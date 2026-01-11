const express = require('express')
const app = express()
const port = 3001
const cors = require('cors');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
const bcrypt = require('bcryptjs');

dotenv.config();

app.use(express.json());
app.use(cors({
  origin: 'http://localhost:3000',
  allowedHeaders: ['Content-Type', 'Authorization'],
}));

const authenticateJWT = (req, res, next) => {
  const token = req.headers['authorization']?.split(' ')[1];
  if (!token) return res.status(403).send('Acesso negado');

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).send('Acesso negado');
    req.user = user;
    next();
  });
};

const generateToken = (user) => {
  return jwt.sign({ id: user.id, email: user.email }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};

// const generateHash = async (password) => {
//   const salt = await bcrypt.genSalt(10);
//   const hash = await bcrypt.hash(password, salt);
//   console.log('Senha criptografada:', hash);
// };

const users = [{
  id: 1, name:'Pitágoras',
  email: 'pitagoras@math.com',
  password: '$2a$10$zAiQ.Xfv6w1JLV9H3BPn7u1oV4CtS2Z2Db9puJ9AjF4OeQXfzj3me'
}]

app.get('/', (req, res) => {
  res.send('Hello World!')
});

app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  const user = users.find(user => user.email === email);
  const passwordMatch = await bcrypt.compare(password, user.password) 
  if (!user || !passwordMatch) {
    return res.status(401).send('Credenciais inválidas');
  }

  const token = generateToken(user);
  res.json({ token });
});

app.post('/calculate', authenticateJWT, (req, res) => {
  const { value1, value2, operation } = req.body;

  let result;

  switch (operation) {
    case 'sum':
      result = value1 + value2;
      break;
    case 'subtract':
      result = value1 - value2;
      break;
    case 'multiply':
      result = value1 * value2;
      break;
    case 'divide':
      if (value2 === 0) {
        return res.status(400).send('Não é possível dividir por zero');
      }
      result = value1 / value2;
      break;
    default:
      return res.status(400).send('Operação inválida');
  }
  res.json({
    message: `O resultado é ${result}`,
    result: result
  })
})

app.listen(port, () => {
  console.log(`Servidor inciado na porta ${port}`)
})
