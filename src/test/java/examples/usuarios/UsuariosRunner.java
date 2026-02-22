package examples.usuarios;

import com.intuit.karate.junit5.Karate;

public class UsuariosRunner {
    @Karate.Test
    Karate testUsuarios() {
        return Karate.run("usuarios").relativeTo(getClass());
    }
}
