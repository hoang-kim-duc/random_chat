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
end
