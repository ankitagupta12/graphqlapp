# ruby graphql tutorial part I

Below are the step by step instructions used to create the graphqlapp. This tutorial is aimed at going a step further than just setting up graphql in a rails project - by establishing a clean folder structure and graphql best practices. Part II of this tutorial will walk through steps to optimize a real-world graphql application.

The model definitions and graphql queries/types can be adapted to suit the needs of a real world application.

  1. Create a new graphql app using the following command:
  rails new graphqlapp --database=postgresql

  2. Setup database

    bundle exec rake db:create

  3. To initialise the app with graphql

  - Add to the gemfile

      `gem 'graphql', '~>1.7.1'`

  - Then run `rails g graphql:install`

  4. Add customers, tables, and items tables

  ```
    class AddCustomers < ActiveRecord::Migration[5.2]
      def change
        create_table :customers do |t|
          t.string :name
          t.integer :table_id
          t.timestamps null: false
        end
        add_foreign_key :customers, :tables, dependent: :delete
      end
    end
  ```

  ```
    class AddTables < ActiveRecord::Migration[5.2]
      def change
        create_table :tables do |t|
          t.string :name
          t.integer :capacity
          t.timestamps null: false
        end
      end
    end
  ```

  ```
    class AddTableItems < ActiveRecord::Migration[5.2]
      def change
        create_table :items do |t|
          t.string :name
          t.integer :customer_id
          t.text :preferences
          t.timestamps null: false
        end
        add_foreign_key :items, :customers, dependent: :delete
      end
    end
  ```

  5. Add app/graphql/types/customer_type.rb, app/graphql/types/table_type.rb, and app/graphql/types/item_type.rb

  ```
    Types::CustomerType = GraphQL::ObjectType.define do
      interfaces [Interfaces::Model]

      name 'Customer'
      description 'customer of a table'

      field :name, !types.String
      field :table, Types::TableType
      field :items, types[Types::ItemType]
    end
  ```

  ```
    Types::TableType = GraphQL::ObjectType.define do
      interfaces [Interfaces::Model]

      name 'Table'
      description 'a table in the restaurant'

      field :name, !types.String
      field :capacity, !types.Int
      field :customers, types[Types::CustomerType]
    end
  ```

  ```
    Types::ItemType = GraphQL::ObjectType.define do
      interfaces [Interfaces::Model]

      name 'Item'
      description 'item ordered by customer'

      field :name, !types.String
      field :preferences, !types.String
      field :customer, Types::CustomerType
      field :status, !Enums::ItemStatus
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

   - Create a model to type mapping because when a field's return type is an interface, graphQL needs to figure out which object to use for return type.

   - Add the following `resolve_type` to the graphqlapp_schema.rb file. Your new file should look like this:
  ```
      GraphqlappSchema = GraphQL::Schema.define do
        mutation(Types::MutationType)
        query(Types::QueryType)

        resolve_type ->(_type, _record, _ctx) do
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

  Add this scalar to the fields to the interface `model.rb`:
  ```
    field :createdAt, !Types::DateTimeType, property: :created_at
    field :updatedAt, !Types::DateTimeType, property: :updated_at
  ```

  7. Create a new folder called `fields`. Fields can have _complexity_ values which describe the computation cost of resolving the field.


  - Add a new file called `files/query_customer.rb`, `files/query_item.rb` and another called `files/query_table.rb`

  ```
      # Customer query
      Fields::QueryCustomer = GraphQL::Field.define do
        description "a customer"
        type(Types::CustomerType)

        argument :id, types.ID

        resolve ->(obj, args, ctx){
          Customer.find(args[:id])
        }
      end

  ```

  ```
    # Table query
    Fields::QueryTable = GraphQL::Field.define do
      description "a table"
      type(Types::TableType)

      argument :id, types.ID

      resolve ->(obj, args, ctx){
        Table.find(args[:id])
      }
    end
  ```

  ```
      # Item query
      Fields::QueryItem = GraphQL::Field.define do
        description "an item"
        type(Types::ItemType)

        argument :id, types.ID

        resolve ->(obj, args, ctx){
          Item.find(args[:id])
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
        field :table, Fields::QueryTable
        field :customer, Fields::QueryCustomer
        field :item, Fields::QueryItem
      end
  ```

  8. Start rails server by typing `rails s` and go to `localhost:3000/graphiql`. Type this query:
  ```
    query{
      item(id: 1){
        id
        name
        preferences
        status
        createdAt
        updatedAt
      }
    }
  ```
