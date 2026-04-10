-- 1. Create the USERS table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    contact_info VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- 2. Create the GROUP_BUY_EVENTS table
CREATE TABLE group_buy_events (
    event_id SERIAL PRIMARY KEY,
    creator_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    target_quantity INT NOT NULL CHECK (target_quantity > 0),
    current_quantity INT DEFAULT 0,
    deadline TIMESTAMPTZ NOT NULL,
    status VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Completed', 'Expired')),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_creator FOREIGN KEY (creator_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 3. Create the ORDERS table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    split_quantity INT NOT NULL DEFAULT 1 CHECK (split_quantity > 0),
    payment_status VARCHAR(20) DEFAULT 'Pending' CHECK (payment_status IN ('Pending', 'Paid', 'Refunded')),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_event FOREIGN KEY (event_id) REFERENCES group_buy_events(event_id) ON DELETE CASCADE,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
