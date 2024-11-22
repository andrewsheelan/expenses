# Expense Management Application

[![CI](https://github.com/andrewsheelan/expenses/actions/workflows/ci.yml/badge.svg)](https://github.com/andrewsheelan/expenses/actions/workflows/ci.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby](https://img.shields.io/badge/ruby-8.0.0-red.svg)](https://www.ruby-lang.org/en/)
[![Rails](https://img.shields.io/badge/rails-8.0.0-red.svg)](https://rubyonrails.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A modern expense tracking application built with Ruby on Rails, featuring real-time chat functionality and beautiful dark-themed UI.

## Features

### Expense Management
- Track personal expenses with categories
- Monthly spending analytics
- Spending predictions using linear regression
- Interactive charts and visualizations
- Category-wise expense distribution
- Detailed expense history

### User Authentication
- Secure user registration and login
- Password reset functionality
- Protected routes and resources
- User-specific data isolation

### Real-time Chat
- User-to-user private messaging
- Real-time message updates
- Modern chat interface
- Message history
- User avatars and status
- Conversation management

### Dashboard Analytics
- Monthly spending trends
- Category distribution charts
- Spending predictions
- Quick stats cards
- Interactive data visualization

## Technical Stack

### Backend
- Ruby on Rails 8.0
- SQLite database
- Devise authentication
- Active Record ORM
- Real-time updates with Turbo Streams

### Frontend
- Tailwind CSS for styling
- Stimulus.js for JavaScript behaviors
- Hotwire for real-time features
- Chart.js for data visualization
- Modern dark theme UI

## Models

### User
- Email authentication
- Has many expenses and categories
- Manages conversations and messages
- Profile information

### Expense
- Belongs to user and category
- Tracks amount, date, and description
- Supports custom titles
- Date-based organization

### Category
- User-specific categories
- Expense associations
- Validation rules
- Prevents deletion with existing expenses

### Conversation
- User-to-user messaging
- Sender and recipient associations
- Message management
- Real-time updates

### Message
- Belongs to conversation and user
- Real-time broadcasting
- Content validation
- Timestamp tracking

## Features in Detail

### Expense Tracking
- Create, read, update, delete expenses
- Categorize expenses
- Track spending over time
- Filter and search functionality
- Export capabilities

### Analytics Dashboard
- Monthly spending trends
- Category-wise distribution
- Predictive analytics
- Interactive charts
- Custom date ranges

### Messaging System
- Real-time chat between users
- Message history
- User online status
- Conversation management
- Unread message indicators

## Installation

1. Clone the repository
```bash
git clone [repository-url]
cd expenses
```

2. Install dependencies
```bash
bundle install
```

3. Setup database
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Start the server
```bash
rails server
```

5. Visit http://localhost:3000

## Test Users

The seed file creates two test users:
- Email: john@example.com (Password: password123)
- Email: jane@example.com (Password: password123)

## Development

### Running Tests
```bash
rails test
```

### Code Style
- Follow Ruby style guide
- Use meaningful variable names
- Add comments for complex logic
- Keep methods small and focused

## Security Features
- User authentication with Devise
- Protected routes and resources
- Data isolation between users
- Secure password handling
- XSS protection
- CSRF protection

## UI/UX Features
- Responsive design
- Dark theme
- Interactive elements
- Real-time updates
- Loading states
- Error handling
- Success notifications

## Future Enhancements
- Advanced reporting
- Budget tracking
- File attachments in chat
- Email notifications
- Mobile app version
- Export/Import functionality
- Advanced search features

## Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License
This project is licensed under the MIT License - see the LICENSE.md file for details
