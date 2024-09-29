module 0x1::demarket {
    use 0x1::item;
    use 0x1::order;
    use 0x1::governance;

    struct Marketplace has store {
        items: vector<item::Item>,
        orders: vector<order::Order>,
    }

    public fun initialize() {
        let market = Marketplace { items: vec[], orders: vec[] };
        move_to(@signer, market);
    }

    public fun create_item(owner: address, name: vector<u8>, price: u64) {
        let item = item::Item { id: vector_length(market.items), owner, name, price };
        market.items.push(item);
    }

    public fun create_order(buyer: address, item_id: u64) {
        
        let order = order::Order { buyer, item_id, status: order::OrderStatus::Pending };
        market.orders.push(order);
    }

    public fun accept_order(seller: address, order_id: u64) {
        
        let order = &mut market.orders[order_id];
        order.status = order::OrderStatus::Accepted;
    }


}
