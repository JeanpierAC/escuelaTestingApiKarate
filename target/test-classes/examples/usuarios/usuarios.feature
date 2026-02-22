Feature: Automatizar Pet Store

Background:
* url apiPetStore

@T-1
Scenario: Crear un nuevo usuario de Pet Store

* def userPet =
    """
    [
      {
        "id": 100,
        "username": "juan123",
        "firstName": "Juan",
        "lastName": "Perez",
        "email": "juan@test.com",
        "password": "1234",
        "phone": "123456789",
        "userStatus": 1
      }
    ]
    """

Given path '/user/createWithList'
And request userPet
When method post
Then status 200
* print response

@T-2
Scenario: Obtener inventario

Given path '/store/inventory'
When method GET
Then status 200

* print response

@T-3
Scenario Outline: Buscar usuario

    Given path 'user/' + '<username>'
    When method GET
    Then status 200
    And match response.username == username
    And print response

    Examples:
        | username |
        | string   |


@T-4
Scenario: Actualizar usuario string

    * def updatedUser =
    """
    {
      "id": 0,
      "username": "string",
      "firstName": "Juan",
      "lastName": "Actualizado",
      "email": "nuevo@test.com",
      "password": "1234",
      "phone": "999999999",
      "userStatus": 1
    }
    """

    Given path 'user', 'string'
    And request updatedUser
    When method PUT
    Then status 200
    And match response.code == 200
    And print response


    @T-5
    Scenario Outline: Eliminar usuario

        Given path 'user/' + '<username>'
        When method DELETE
        Then status 200
        And match response.message == username
        And print response

        Examples:
            | username |
            | string   |

    @T-6
    Scenario: Login correcto

        Given path 'user', 'login'
        And param username = 'string'
        And param password = 'string'
        When method GET
        Then status 200
        And match response.code == 200
        And match response.message contains 'logged in user'
        And match header X-Rate-Limit != null
        And match header X-Expires-After != null
        And print response

    @T-7
    Scenario: Logout correcto

        Given path 'user', 'logout'
        When method GET
        Then status 200
        And match response.code == 200
        And match response.message == 'ok'
        And print response