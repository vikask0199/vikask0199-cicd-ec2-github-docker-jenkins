import express, { Request, Response } from 'express';
import dotenv from 'dotenv';

// Load environment variables
if (process.env.NODE_ENV === 'production') {
  dotenv.config({ path: '.env.production' });
} else {
  dotenv.config({ path: '.env.development' });
}

const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req: Request, res: Response) => {
  res.json({
    message: `Hello from CI/CD Pipeline in ${process.env.NODE_ENV} mode!`
  });
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT} in ${process.env.NODE_ENV} mode`);
});
