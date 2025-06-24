# 🗣️ Gossip Project - A Rails Social App

Welcome to **Gossip Project**, a Ruby on Rails application designed as part of The Hacking Project curriculum.  
This app simulates a social network for sharing juicy gossip, with tags, comments, likes, and more.

## 🎯 Learning Objectives

- Master complex ActiveRecord associations
- Implement many-to-many and polymorphic relationships
- Seed realistic test data using the Faker gem
- Practice organizing a Rails backend without views/controllers

---

## 🧱 Models and Database Design

### 👤 User
- `first_name`, `last_name`, `description`, `email`, `age`
- Belongs to a `City`
- Has many `gossips`, `comments`, `likes`, `private_messages_sent`

### 🏙️ City
- `name`, `zip_code`
- Has many `users`

### 💬 Gossip
- `title`, `content`
- Belongs to a `User`
- Has and belongs to many `Tags`
- Has many `comments` (polymorphic)
- Has many `likes` (polymorphic)

### 🏷️ Tag
- `title`
- Has and belongs to many `Gossips`

### 📝 Comment *(optional, polymorphic)*
- `content`
- Belongs to a `User`
- Belongs to a `commentable` (either a Gossip or another Comment)

### ❤️ Like *(optional, polymorphic)*
- Belongs to a `User`
- Belongs to a `likeable` (either a Gossip or a Comment)

### ✉️ PrivateMessage *(optional)*
- `content`
- Belongs to a sender (`User`)
- Has and belongs to many recipients (`Users`)

---

## 🔗 Associations Example

```ruby
User.first.gossips
Gossip.first.tags
Tag.last.gossips
Gossip.first.comments
Comment.first.commentable # could be a Gossip or another Comment
User.first.private_messages_sent