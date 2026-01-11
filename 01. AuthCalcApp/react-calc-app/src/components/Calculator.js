import { useState, useEffect } from 'react';
import axios from 'axios';
import '../App.css';
import { useNavigate } from 'react-router-dom';

const Calculator = () => {
  const [value1, setValue1] = useState('');
  const [value2, setValue2] = useState('');
  const [result, setResult] = useState(null);
  const [error, setError] = useState('');
  const navigate = useNavigate();
  

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (!token) {
      navigate('/login');
    }
  }, [navigate]);

  const handleOperation = async (operation) => {
    const token = localStorage.getItem('token');
    if (!value1 || !value2) {
      setError('Todos os campos são obrigatórios');
      return;
    }

    try {
      const response = await axios.post('http://localhost:3001/calculate', {
        value1: parseFloat(value1.replace(',', '.')),
        value2: parseFloat(value2.replace(',', '.')),
        operation,
      }, { headers: { Authorization: `Bearer ${token}` } } );

      setResult(response.data.message);
      setError('');
    } catch (err) {
      setError('Erro ao realizar o cálculo');
    }
  };

  return (
    <div className="calculator">
      <h2>Calculadora</h2>
      {error && <p className="error-message">{error}</p>}

      <input
        type="text"
        value={value1}
        onChange={(e) => setValue1(e.target.value)}
        placeholder="Valor 1"
      />
      <input
        type="text"
        value={value2}
        onChange={(e) => setValue2(e.target.value)}
        placeholder="Valor 2"
      />

      <div className='calculator-buttons'>
        <button onClick={() => handleOperation('sum')}>Somar</button>
        <button onClick={() => handleOperation('subtract')}>Subtrair</button>
        <button onClick={() => handleOperation('multiply')}>Multiplicar</button>
        <button onClick={() => handleOperation('divide')}>Dividir</button>
      </div>

      {result !== null && <p className="result">{result}</p>}
    </div>
  );
};

export default Calculator;
