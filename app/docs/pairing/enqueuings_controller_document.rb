module Pairing::EnqueuingsControllerDocument
    extend Apipie::DSL::Concern

    api :POST, "/enqueuing", "enqueue user"
    example <<-EG
    {
      "action": "enqueue_user",
      "success": true,
      "errors": []
    }
    EG
    def create; end

    api :DELETE, "/enqueuing", "enqueue user"
    example <<-EG
    {
      "action": "dequeue_user",
      "success": true,
      "errors": []
    }
    EG
    def destroy; end
end
