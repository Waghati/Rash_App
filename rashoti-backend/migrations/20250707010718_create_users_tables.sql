-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    user_type VARCHAR(50) NOT NULL CHECK (user_type IN ('student', 'teacher', 'parent')),
    profile_image TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    metadata JSONB
);

-- Students table
CREATE TABLE students (
    id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    grade VARCHAR(50) NOT NULL,
    subjects TEXT[] NOT NULL DEFAULT '{}',
    parent_id UUID REFERENCES users(id),
    school_id UUID,
    moodle_user_id INTEGER
);

-- Teachers table
CREATE TABLE teachers (
    id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    subjects TEXT[] NOT NULL DEFAULT '{}',
    grades TEXT[] NOT NULL DEFAULT '{}',
    school_id UUID,
    department VARCHAR(255),
    moodle_user_id INTEGER
);

-- Parents table
CREATE TABLE parents (
    id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    children_ids UUID[] NOT NULL DEFAULT '{}',
    occupation VARCHAR(255)
);

-- Create indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_user_type ON users(user_type);
CREATE INDEX idx_students_parent_id ON students(parent_id);
CREATE INDEX idx_students_moodle_user_id ON students(moodle_user_id);
CREATE INDEX idx_teachers_moodle_user_id ON teachers(moodle_user_id);