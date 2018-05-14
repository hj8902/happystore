/* HappyStore Databse Structure */

DROP TABLE IF EXISTS  "products";

CREATE TABLE "products" (
    "id" bigserial primary key,
    "name" text NOT NULL,
    "price" integer NOT NULL,
    "quantity" integer NOT NULL,
    "created_at" timestamp default NULL,
    "updated_at" timestamp default NULL
);

DROP TABLE IF EXISTS "sales";

CREATE TABLE "sales" (
    "id" bigserial primary key,
    "product_id" bigserial unique NOT NULL,
    "description" text default NULL,
    "percentage" integer NOT NULL,
    "price" integer NOT NULL,
    "created_at" timestamp default NULL,
    "updated_at" timestamp default NULL
);

DROP TABLE IF EXISTS "categories";

CREATE TABLE "categories" (
    "id" bigserial primary key,
    "name" text NOT NULL,
    "created_at" timestamp default NULL,
    "updated_at" timestamp default NULL
);

DROP TABLE IF EXISTS "category_hierarchies";

CREATE TABLE "category_hierarchies" (
    "id" bigserial primary key,
    "category_id" bigserial NOT NULL,
    "parent_category_id" bigserial NOT NULL,
    "created_at" timestamp default NULL,
    "updated_at" timestamp default NULL,
    unique ("category_id", "parent_category_id")
);

DROP TABLE IF EXISTS "categories_products";

CREATE TABLE "categories_products" (
    "id" bigserial primary key,
    "category_id" bigserial NOT NULL,
    "product_id" bigserial NOT NULL,
    "created_at" timestamp default NULL,
    "updated_at" timestamp default NULL,
    unique ("category_id", "product_id")
);

DROP TABLE IF EXISTS "price_lines";

CREATE TABLE "price_lines" (
    "id" bigserial primary key,
    "min_price" integer NOT NULL,
    "max_price" integer NOT NULL
);

DROP TABLE IF EXISTS "price_lines_products";

CREATE TABLE "price_lines_products" (
    "id" bigserial primary key,
    "product_id" bigserial NOT NULL,
    "price_line_id" bigserial NOT NULL,
    unique ("product_id", "price_line_id")
);
