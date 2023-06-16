module move_gas_optimization::variable_packing {
    use std::signer;

    struct MyResource2 has key, store {
        x8: u8, 
        x32: u64,
        x24: u64
    }

    struct MyPackedResource has key, store {
        x: u64
    }

    //aptos move run --function-id 'default::variable_packing::create_resource'
    public entry fun create_resource(account: signer) {
        move_to<MyResource>(&account, MyResource {
                x8: 1,
                x32: 1,
                x24: 1
            });
    }

    //aptos move run --function-id 'default::variable_packing::create_packed_resource'
    // 503
    public entry fun create_packed_resource(account: signer) {
        move_to<MyPackedResource>(&account, MyPackedResource {
                x: 1
            });
    }

    //aptos move run --function-id 'default::variable_packing::no_variable_packing'
    public entry fun no_variable_packing(account: &signer) 
    acquires MyResource{
        let resource = borrow_global<MyResource>(signer::address_of(account));

        let k:u64 = 0;
        while (k < 10000) {
            let x8:  u8  = resource.x8;
            let x32: u64 = resource.x32;
            let x24: u64 = resource.x24;
            
            k = k + 1;
        };
    }
    // 746 Octa


    //aptos move run --function-id 'default::variable_packing::variable_storage'
    public entry fun variable_packing(account: &signer) 
    acquires MyPackedResource{
        let packed_resource = borrow_global<MyPackedResource>(signer::address_of(account));
        let x: u64 = packed_resource.x;

        let k:u64 = 0;
        while (k < 10000) {
            let x8  = (x & 0xF);
            let x32 = ((x & (0xFFFF << 8)) >> 8);
            let x24 = ((x & (0xFFF << 40)) >> 40);
            
            k = k + 1;
        };
    }
    // 630 Octa

}
