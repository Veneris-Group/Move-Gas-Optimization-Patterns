module move_gas_optimization::read_instead_of_write {
    use std::signer;
    use std::vector;

    struct MyResource has key, store {
        a:u128,
        b:u128,
        c:u128,
        d:u128,
        vec: vector<u64>,
        w:u8,
        x:u8,
        y:u8,
        z:u8
    }


    //aptos move run --function-id 'default::read_instead_of_write::create_resource'
    public entry fun create_resource(account: signer) {
        let vec = vector::empty<u64>();
        let k:u64 = 0;
        while (k < 100) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };
        move_to<MyResource>(&account, MyResource {
                a:1000,
                b:1000,
                c:1000,
                d:1000,
                vec: vec,
                w:10,
                x:10,
                y:10,
                z:10
            });
    }


    //aptos move run --function-id 'default::read_instead_of_write::reading'
    public entry fun reading(account: &signer) 
    acquires MyResource{
        let k:u64 = 0;
        while (k < 1000) {
            let resource = borrow_global<MyResource>(signer::address_of(account));
            let x = resource.x;
            k = k + 1;
        };
    }
    // 44 Octa


    //aptos move run --function-id 'default::read_instead_of_write::writing'
    public entry fun writing(account: &signer) 
    acquires MyResource{
        let k:u64 = 0;
        while (k < 1000) {
            let resource = borrow_global_mut<MyResource>(signer::address_of(account));
            resource.x = 1;
            k = k + 1;
        };
    }
    // 3663 Octa

}
