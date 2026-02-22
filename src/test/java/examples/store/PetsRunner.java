package examples.store;

import com.intuit.karate.junit5.Karate;

public class PetsRunner {
    @Karate.Test
    Karate testPets() {
        return Karate.run("store_pet").relativeTo(getClass());
    }
}