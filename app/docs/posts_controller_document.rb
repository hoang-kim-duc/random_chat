# frozen_string_literal: true

module PostsControllerDocument
  extend Apipie::DSL::Concern

  api :GET, '/users/:user_id/posts', 'get all posts of an user'
  param :page, Integer, require: false
  param :per_page, Integer, require: false
  example <<-EG
  [
    {
        "id": 2,
        "image_url": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--f68185bc85d34229ba5dcf534161bbb16b0622ff/Screen%20Shot%202022-07-04%20at%2022.33.12.png",
        "caption": "edit post",
        "user_id": 35,
        "no_of_reactions": 0,
        "created_at": "2022-07-10T11:46:15.576+0700"
    },
    {
        "id": 1,
        "image_url": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--f19e32cd18f0c612cb950ce11f2f41962b1da631/Screen%20Shot%202022-07-04%20at%2022.33.12.png",
        "caption": "edit post",
        "user_id": 35,
        "no_of_reactions": 0,
        "created_at": "2022-07-10T11:40:46.501+0700"
    },
    {
        "id": 3,
        "image_url": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--8c88a0d5cdc0441395275498f43adbad11415502/Screen%20Shot%202022-07-04%20at%2022.33.12.png",
        "caption": "first post",
        "user_id": 35,
        "no_of_reactions": 0,
        "created_at": "2022-07-10T12:12:05.500+0700"
    },
    {
        "id": 4,
        "image_url": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--5f7d4ca4be7e6f05e08a898344e6580e9983b848/Screen%20Shot%202022-07-04%20at%2022.33.12.png",
        "caption": "first post",
        "user_id": 35,
        "no_of_reactions": 0,
        "created_at": "2022-07-10T13:30:02.066+0700"
    }
  ]
  EG
  def index; end

  api :POST, '/posts/:post_id', 'create a post'
  param :post, Hash, require: true do
    param :caption, String, require: true
    param :image, ActiveStorage::Attached::One, require: true
  end
  example <<-EG
  {
    "action": "enqueue_user",
    "success": true,
    "errors": []
  }
  EG
  def create; end

  api :PUT, '/posts/:post_id', 'update a post'
  param :post, Hash, require: true do
    param :caption, String, require: true
    param :image, ActiveStorage::Attached::One, require: true
  end
  example <<-EG
  {
    "id": 1,
    "image_url": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--f19e32cd18f0c612cb950ce11f2f41962b1da631/Screen%20Shot%202022-07-04%20at%2022.33.12.png",
    "caption": "edit post",
    "user_id": 35,
    "no_of_reactions": 1,
    "created_at": "2022-07-10T11:40:46.501+0700"
  }
  EG
  def update; end

  api :POST, 'posts/:post_id/toggle_react', 'toggle reaction on post'
  example <<-EG
  {
    "success": true
  }
  EG
  def toggle_react; end

  api :DELETE, 'posts/:post_id', 'delete a post'
  example <<-EG
  { 
    success: true
  }
  EG
  def destroy; end
end
