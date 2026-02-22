Feature: Automatizar Pet Store

  Background:
    * url apiPetStore

  @T-1
  Scenario: Crear una nueva orden

    * def orderPet =
    """
    {
      "id": 0,
      "petId": 0,
      "quantity": 1,
      "shipDate": "2026-02-22T12:01:14.080Z",
      "status": "placed",
      "complete": true
    }
    """

    Given path '/store/order'
    And request orderPet
    When method POST
    Then status 200
    * print response

  @T-2
  Scenario: Obtener inventario

    Given path '/store/inventory'
    When method GET
    Then status 200

    * print response

  @T-3
  Scenario Outline: Buscar ID por inventario

    Given path 'store', 'order', <idPet>
    When method get
    Then status 200
    And print response

    Examples:
      | idPet   |
      |   1     |
      |   3     |