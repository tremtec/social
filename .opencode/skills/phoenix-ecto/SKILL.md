---
name: phoenix-ecto
description: Ecto best practices for schemas, changesets, queries, and migrations
license: MIT
compatibility: opencode
metadata:
  scope: phoenix
  category: database
---

## What I do

Enforce Ecto best practices for database schemas, changesets, queries, and migrations.

## When to use me

- Creating new schemas
- Writing changeset validations
- Building queries with Ecto.Query
- Creating migrations

## Rules

### Schemas

1. **Always use `:string` type** for text columns (even `:text` fields):

   ```elixir
   field :name, :string
   field :description, :string  # Yes, even for "long text"
   ```

2. **Use `:binary_id` for UUIDs**:

   ```elixir
   @primary_key {:id, :binary_id, autogenerate: true}
   @foreign_key_type :binary_id
   ```

3. **Never nest modules** - each module in its own file to avoid cyclic dependencies

### Changesets

1. **Access fields correctly** - never use map access syntax on structs:

   ```elixir
   # WRONG
   changeset[:field]

   # CORRECT
   my_struct.field
   Ecto.Changeset.get_field(changeset, :field)
   ```

2. **Fields set programmatically must NOT be in `cast`**:

   ```elixir
   # WRONG (security issue)
   |> cast(attrs, [:user_id, :name])

   # CORRECT
   |> cast(attrs, [:name])
   |> put_assoc(:user, current_scope.user)  # or set manually
   ```

3. **`validate_number/2` does NOT support `:allow_nil`** - validations only run if field changed

### Queries

1. **Always preload associations** when they'll be accessed in templates:

   ```elixir
   def get_message!(id) do
     Message
     |> Repo.get!(id)
     |> Repo.preload(:user)
   end

   # Or inline with query
   from m in Message, preload: [:user]
   ```

2. **Use parameterized queries** to prevent SQL injection:

   ```elixir
   # Safe
   from(f in Fruit, where: f.quantity >= ^min_q)

   # Unsafe (NEVER do this)
   Ecto.Adapters.SQL.query(Repo, "SELECT ... WHERE quantity > #{min_q}")
   ```

3. **Pass `current_scope` as first argument** to context functions:
   ```elixir
   def list_organizations(%Scope{} = scope, opts \\ []) do
     Organization
     |> where([o], o.user_id == ^scope.user.id)
     |> Repo.all()
   end
   ```

### Migrations

**Always use `mix ecto.gen.migration`** with underscore naming:

```bash
mix ecto.gen.migration create_users_table
mix ecto.gen.migration add_status_to_organizations
```

## Key Patterns

### Scoped Context Functions

```elixir
def list_posts(%Scope{} = scope) do
  Post
  |> where([p], p.user_id == ^scope.user.id)
  |> Repo.all()
end

def get_post!(%Scope{} = scope, id) do
  Post
  |> where([p], p.id == ^id and p.user_id == ^scope.user.id)
  |> Repo.one!()
end
```

## Key Files

- `lib/social/repo.ex` - Ecto repo
- `lib/social/accounts/` - Accounts context schemas
- `lib/social/organizations/` - Organizations context schemas
- `priv/repo/migrations/` - Migration files
