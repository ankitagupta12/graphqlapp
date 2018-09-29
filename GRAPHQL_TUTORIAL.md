# ruby graphql tutorial part I

Below are the step by step instructions used to create the graphqlapp. This tutorial is aimed at going a step further than just setting up graphql in a rails project - by establishing a clean folder structure and graphql best practices. Part II of this tutorial will walk through steps to optimize a real-world graphql application.

The model definitions and graphql queries/types can be adapted to suit the needs of a real world application.

  1. Create a new graphql app using the following command:
  rails new graphqlapp --database=postgresql

  2. Setup database

    `bundle exec rake db:create`

  3. To initialise the app with graphql

    - Add to the gemfile

      `gem 'graphql', '~>1.7.1'`

    - Then run `rails g graphql:install`

  4. Add articles and comments tables

  ```
    class AddArticles < ActiveRecord::Migration[5.2]
      def change
        create_table :articles do |t|
          t.string :title
          t.text :text
          t.timestamps null: false
        end
      end
    end
  ```

  ```
    class AddComments < ActiveRecord::Migration[5.2]
      def change
        create_table :comments do |t|
          t.text :body
          t.integer :article_id
          t.timestamps null: false
        end
        add_foreign_key :comments, :articles, dependent: :delete
      end
    end
  ```

  5. Add app/grpahql/types/comment_type.rb and app/graphql/types/article_type.rb

  ```
    Types::ArticleType = GraphQL::ObjectType.define do
      name 'Article'
      description 'an article from the blog'

      field :id, !types.Int
      field :title, !types.String
      field :text, !types.String
      field :createdAt, !types.String, property: :created_at
      field :updatedAt, !types.String, property: :updated_at
      field :comments, types[Types::CommentType]
    end
  ```

  ```
    Types::CommentType = GraphQL::ObjectType.define do
      name 'Comment'
      description 'comment for an article'

      field :id, !types.Int
      field :body, !types.String
      field :createdAt, !types.String, property: :created_at
      field :updatedAt, !types.String, property: :updated_at
    end
  ```

  6. Add an interface to extract the common fields of a model:
  - Create file graphql/interfaces/model.rb

  ```
      Interfaces::Model = GraphQL::InterfaceType.define do
        name 'ModelInterface'

        field :id, !types.ID
        field :createdAt, !Types::DateTimeType, property: :created_at
        field :updatedAt, !Types::DateTimeType, property: :updated_at
      end
  ```

   - Create a model to type mapping because when a field's return type is an interface, graphQL needs to figure out which object to use for return type. Define app/services/graphql_services/type_model_mapping_service.rb

  ```
      # Service to convert Active Record Model to GraphQL Type
      class GraphqlServices::TypeModelMappingService < BaseService
        MODEL_TYPE_MAPPING = {
          Article: Types::ArticleType,
          Comment: Types::CommentType
        }.freeze

        def perform(model_class)
          MODEL_TYPE_MAPPING[model_class.to_s.to_sym]
        end
      end
  ```

   - Add the following `resolve_type` to the graphqlapp_schema.rb file. Your new file should look like this:
  ```
      GraphqlappSchema = GraphQL::Schema.define do
        mutation(Types::MutationType)
        query(Types::QueryType)

        resolve_type ->(_type, record, _ctx) do
          GraphqlServices::TypeModelMappingService.new.perform(record.class)
        end
      end
  ```

   - Define new scalar type for date time:

  ```
      Types::DateTimeType = GraphQL::ScalarType.define do
        name 'DateTime'
        description 'The DateTime scalar type represents date time strings'

        coerce_input ->(value, _ctx) { Time.zone.parse(value) }
        coerce_result ->(value, _ctx) { value.strftime('%Y-%m-%dT%H:%M:%S.%L%:z') }
      end
  ```

   - Update graphql/types/article.rb and graphql/types/comment.rb

  ```
      Types::CommentType = GraphQL::ObjectType.define do
        interfaces [Interfaces::Model]

        name 'Comment'
        description 'comment for an article'

        field :body, !types.String
      end
  ```

  ```
      Types::ArticleType = GraphQL::ObjectType.define do
        interfaces [Interfaces::Model]

        name 'Article'
        description 'an article from the blog'

        field :title, !types.String
        field :text, !types.String
        field :comments, types[Types::CommentType]
      end

  ```


  7. Create a new folder called `fields`. Fields can have _complexity_ values which describe the computation cost of resolving the field.


  - Add a new file called `files/query_article.rb` and another called `files/query_comment.rb`

  ```
      # Article query
      Fields::QueryArticle = GraphQL::Field.define do
        description "an article"
        type(Types::ArticleType)

        argument :id, !types.Int

        resolve ->(obj, args, ctx){
          Article.find(args[:id])
        }
      end

  ```

  ```
      # Comment query
      Fields::QueryComment = GraphQL::Field.define do
        description "an article"
        type(Types::ArticleType)

        argument :id, !types.Int

        resolve ->(obj, args, ctx){
          Comment.find(args[:id])
        }
      end
  ```

  - Add this to your query file:

  ```
      Types::QueryType = GraphQL::ObjectType.define do
        name "Query"
        # Add root-level fields here.
        # They will be entry points for queries on your schema.

        # TODO: remove me
        field :article, Fields::QueryArticle
        field :comment, Fields::QueryComment
      end
  ```

  8. Start rails server by typing `rails s` and go to `localhost:3000/graphiql`. Type this query:
  ```
    query{
      article(id: 1){
        comments{
          id
          body
        }
        id
        title
        text
      }
    }
  ```
