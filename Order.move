module 0x1::order {
    struct Order has store {
        buyer: address,
        item_id: u64,
        status: OrderStatus,
    }

    enum OrderStatus {
        Pending,
        Accepted,
        Completed,
        Canceled,
    }

    public fun get_order(id: u64): Order {
    
    }
}
