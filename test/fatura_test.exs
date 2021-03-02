defmodule FaturaTest do
  use ExUnit.Case
  doctest Fatura

  test "deve criar uma lista de faturas" do
    faturas = Fatura.criar_fatura(["Internet", "Luz", "Condominio"])
    assert faturas == ["Internet", "Luz", "Condominio"]
  end

  test "deve ordenar uma lista de faturas" do
    faturas = Fatura.criar_fatura(["Internet", "Luz", "Condominio"])
    refute Fatura.ordena_fatura(faturas) == ["Internet", "Luz", "Condominio"]
  end

  test "deve verificar se a conta existe" do
    assert Fatura.fatura_existe?(Fatura.criar_fatura(["Internet", "Luz", "Condominio"]), "Luz") == true
  end

end
