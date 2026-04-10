## Database Design
Below is the ER diagram for our group-buying system:

```mermaid
erDiagram
    %%
    USERS ||--o{ GROUP_BUY_EVENTS : "creates"
    USERS ||--o{ ORDERS : "places"
    GROUP_BUY_EVENTS ||--o{ ORDERS : "contains"
    
    %% Entity Relationships
    USERS ||--o{ GROUP_BUY_EVENTS : "creates"
    USERS ||--o{ ORDERS : "places"
    GROUP_BUY_EVENTS ||--o{ ORDERS : "contains"

    %% Entity Attributes
    USERS {
        int user_id PK "Unique Identifier"
        string username "User Display Name"
        string contact_info "WeChat/Phone"
        datetime created_at "Registration Time"
    }

    GROUP_BUY_EVENTS {
        int event_id PK "Event ID"
        int creator_id FK "References USERS"
        string product_name "e.g. Swiss Roll"
        int target_quantity "Total required"
        int current_quantity "Currently joined"
        datetime deadline "Cutoff time"
        string status "Active / Completed / Expired"
    }

    ORDERS {
        int order_id PK "Order ID"
        int event_id FK "References GROUP_BUY_EVENTS"
        int user_id FK "References USERS"
        int split_quantity "Portions bought"
        string payment_status "Pending / Paid"
        datetime created_at "Order timestamp"
    }# TT
