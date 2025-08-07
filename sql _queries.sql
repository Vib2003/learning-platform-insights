-- Create a new database for the EdTech project
CREATE DATABASE edtech_project;

-- Switch to the newly created database
USE edtech_project;

-- Create the main table to store user engagement data on online courses
CREATE TABLE online_course_engagement (
    user_id INT,                          
    course_category VARCHAR(100),       
    time_spent_on_course FLOAT,          
    number_of_videos_watched INT,        
    number_of_quizzes_taken INT,         
    quiz_scores FLOAT,                   
    completion_rate FLOAT,              
    device_type INT,                     
    course_completion BOOLEAN            
);

-- Preview the first 10 rows of the data
SELECT * FROM online_course_engagement LIMIT 10;

-- Get the total number of records in the table
SELECT COUNT(*) AS total_records FROM online_course_engagement;

-- Check for NULL values in key columns to assess data quality
SELECT 
  SUM(user_id IS NULL) AS null_user_ids,
  SUM(course_category IS NULL) AS null_categories,
  SUM(time_spent_on_course IS NULL) AS null_time_spent,
  SUM(quiz_scores IS NULL) AS null_quiz_scores,
  SUM(course_completion IS NULL) AS null_completion
FROM online_course_engagement;

-- Get all unique course categories present in the data
SELECT DISTINCT course_category FROM online_course_engagement;

-- Find course categories with the highest completion percentages
SELECT 
  course_category,
  COUNT(*) AS total_users,
  SUM(course_completion) AS completed_users,
  ROUND(SUM(course_completion) / COUNT(*) * 100, 2) AS completion_percentage
FROM online_course_engagement
GROUP BY course_category
ORDER BY completion_percentage DESC;

-- Calculate average time spent per course category (in minutes)
SELECT 
  course_category,
  ROUND(AVG(time_spent_on_course), 2) AS avg_time_spent_minutes
FROM online_course_engagement
GROUP BY course_category
ORDER BY avg_time_spent_minutes DESC;

-- Count number of users using each device type per course category
-- device_type: 0 = Desktop, 1 = Mobile
SELECT 
  course_category,
  device_type,
  COUNT(*) AS user_count
FROM online_course_engagement
GROUP BY course_category, device_type
ORDER BY course_category, device_type;

-- Count users by device type specifically within the 'Health' course category
SELECT 
  course_category, 
  device_type, 
  COUNT(*) AS user_count
FROM online_course_engagement
WHERE course_category = 'Health'
GROUP BY course_category, device_type;

-- Calculate average quiz score and user count grouped by course category and device type
SELECT 
    course_category,
    device_type,
    ROUND(AVG(quiz_scores), 2) AS avg_quiz_score,
    COUNT(*) AS user_count
FROM online_course_engagement
GROUP BY course_category, device_type
ORDER BY course_category, device_type;
