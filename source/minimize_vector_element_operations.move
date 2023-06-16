module move_gas_optimization::minimize_vector_element_operations {
    use std::vector;
    
    //aptos move run --function-id 'default::minimize_vector_element_operations::bad_vector_access'
    public entry fun bad_vector_access() {
        let vec = vector::empty<u64>();
        vector::push_back(&mut vec, 1);
        let k:u64 = 0;
        while (k < 1000) {
            k = k + *vector::borrow(&vec, 0);
        };
    }
    // 1295 Octa


    //aptos move run --function-id 'default::minimize_vector_element_operations::good_vector_access'
    public entry fun good_vector_access() {
        let vec = vector::empty<u64>();
        vector::push_back(&mut vec, 1);
        let increment:u64 = *vector::borrow(&vec, 0);
        let k:u64 = 0;
        while (k < 1000) {
            k = k + increment;
        };
    }
    // 41 Octa

}
