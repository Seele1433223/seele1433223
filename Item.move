module 0x1::item {
    struct Item has store {
        id: u64,
        owner: address,
        name: vector<u8>,
        price: u64,
    }

    public fun get_item(id: u64): Item {
        
    }
}
