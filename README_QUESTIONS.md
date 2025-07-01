# Questions Feature

This document describes the new Questions feature that allows users to ask questions about various entities in the system.

## Database Schema

The `questions` table has the following structure:

- `id` - Primary key
- `body` - Text content of the question
- `user_id` - Foreign key to the user who asked the question
- `questionable_type` - Polymorphic association type (e.g., "Skill", "Mentorship")
- `questionable_id` - Polymorphic association ID
- `created_at` - Timestamp
- `updated_at` - Timestamp

## Model Associations

- `Question` belongs to `User`
- `Question` belongs to `questionable` (polymorphic)
- `User` has many `questions`

## API Endpoints

### Basic CRUD Operations

- `GET /questions` - List all questions
- `GET /questions/:id` - Get a specific question
- `POST /questions` - Create a new question
- `PATCH/PUT /questions/:id` - Update a question
- `DELETE /questions/:id` - Delete a question

### Special Endpoints

- `GET /questions/from/:user_id` - Get all questions asked by a specific user
- `GET /questions/from/:questionable_type/:questionable_id` - Get all questions about a specific entity

## Example Usage

### Creating a Question

```json
POST /questions
{
  "question": {
    "body": "What is the best way to learn Rails?",
    "user_id": 1,
    "questionable_type": "Skill",
    "questionable_id": 5
  }
}
```

### Getting Questions by User

```
GET /questions/from/1
```

### Getting Questions about a Skill

```
GET /questions/from/Skill/5
```

## Polymorphic Association

The Question model uses a polymorphic association, which means questions can be associated with any model in the system. For example:

- Questions about Skills
- Questions about Mentorships
- Questions about Meeting Offerings
- etc.

## Files Created/Modified

1. **Migration**: `db/migrate/20250630014248_create_questions.rb`
2. **Model**: `app/models/question.rb`
3. **Controller**: `app/controllers/questions_controller.rb`
4. **Serializer**: `app/serializers/question_serializer.rb`
5. **Routes**: Added to `config/routes.rb`
6. **User Model**: Added `has_many :questions` association
7. **Tests**:
   - `test/models/question_test.rb`
   - `test/controllers/questions_controller_test.rb`
   - `test/fixtures/questions.yml`
