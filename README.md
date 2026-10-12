# 🔍 Rails Girls - Lost & Found

A modern, community-driven web application to report, browse, and recover lost and found items. Built with **Ruby on Rails 8**, PostgreSQL, Hotwire, and Active Storage.

---

## 👥 Mentors & Team

### 🎓 Mentors
- Ankit Shukla
- Harshada Gujar

### 💻 Team Members
- Hridaya Khare
- Prutha Joshi
- Diksha A.
- Diksha Veer
- Mohammad Zeeshan Inamdar

---

## ✨ Features

- 📢 **Item Reporting**: Report both lost and found items with title, description, date, and location.
- 🖼️ **Image Uploads**: Upload photo attachments for items with size and format validation via Active Storage.
- 💬 **Interactive Comments**: Communicate directly on item listings to help locate owners.
- 🔒 **User Authentication**: Secure signup, login, session handling, and password resets using Rails 8 native auth with `bcrypt`.
- ⚡ **Hotwire Acceleration**: Smooth user experience powered by Turbo and Stimulus.
- 🎯 **Status Tracking**: Mark items as resolved once reunited with their owner.

---

## 🛠️ Tech Stack

- **Framework**: Ruby on Rails `~> 8.0.5`
- **Language**: Ruby `3.4.5`
- **Database**: PostgreSQL
- **Frontend / Assets**: Propshaft, Importmap, Hotwire (Turbo & Stimulus)
- **File Storage**: Active Storage
- **Background Jobs / Caching**: Solid Queue, Solid Cache, Solid Cable
- **Web Server**: Puma

---

## 🚀 Getting Started

Follow these steps to set up and run the application locally.

### 1. Prerequisites

Ensure you have the following installed on your machine:
- **Ruby**: `3.4.5` (managed via `rbenv`, `rvm`, or `asdf`)
- **PostgreSQL**: `v14+` running locally
- **Git**
- **Bundler**: `gem install bundler`

### 2. Clone the Repository

```bash
git clone https://github.com/hridaya-khare/rails-girls-lost-and-found.git
cd rails-girls-lost-and-found
```

### 3. Install Dependencies

```bash
bundle install
```

### 4. Database Setup

Configure your PostgreSQL credentials in `config/database.yml` if needed, then run:

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed    # Optional: if seed data is provided
```

### 5. Run the Server

Start the Puma development server:

```bash
bin/rails server
```

Open your browser and navigate to:
```text
http://localhost:3000
```

---

## 🧪 Running Tests & Code Quality

Run the test suite and linters:

```bash
# Run system and unit tests
bin/rails test

# Run RuboCop linter
bundle exec rubocop

# Run security static analysis
bundle exec brakeman
```

---

## 📁 Project Structure Overview

```text
├── app/
│   ├── controllers/      # Items, Comments, Sessions, Registrations, Passwords
│   ├── models/           # Item, Comment, User, Session
│   ├── views/            # ERB views for items, authentication, etc.
│   └── javascript/       # Stimulus controllers and Turbo setup
├── config/
│   ├── database.yml      # Database configuration
│   └── routes.rb         # RESTful routes
├── db/
│   ├── migrate/          # Database migrations
│   └── schema.rb         # Database schema
└── test/                 # Test suites (models, controllers, system tests)
```

---

## 🤝 Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the [MIT License](LICENSE) (or event workshop license).
