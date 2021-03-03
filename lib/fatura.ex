defmodule Fatura do
  @moduledoc """
    Neste modulo executamos funcoes de faturas
  """

  @doc """
    Ao receber `fatura` retorna um array de faturas
      ## Exemplos
      iex> Fatura.criar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20])
      [
        %Fatura.Conta{fatura: "Internet", vencimento: 5},
        %Fatura.Conta{fatura: "Luz", vencimento: 5},
        %Fatura.Conta{fatura: "Condominio", vencimento: 5},
        %Fatura.Conta{fatura: "Internet", vencimento: 10},
        %Fatura.Conta{fatura: "Luz", vencimento: 10},
        %Fatura.Conta{fatura: "Condominio", vencimento: 10},
        %Fatura.Conta{fatura: "Internet", vencimento: 20},
        %Fatura.Conta{fatura: "Luz", vencimento: 20},
        %Fatura.Conta{fatura: "Condominio", vencimento: 20}
      ]
  """

  def criar_faturas(faturas, vencimentos) do
    for vencimento <- vencimentos, fatura <- faturas do
      %Fatura.Conta{fatura: fatura, vencimento: vencimento}
    end
  end

  def pagar_faturas(faturas, vencimento, quantidade) do
    criar_faturas(faturas, vencimento)
    |> ordena_fatura
    |> faturas_a_pagar(quantidade)
  end

  def faturas_a_pagar(faturas, quantidade) do
    Enum.split(faturas, quantidade)
  end

  def save(nome_arquivo, faturas) do
    binary = :erlang.term_to_binary(faturas)
    File.write(nome_arquivo, binary)
  end

  def load(nome_arquivo) do
    case File.read(nome_arquivo) do
      {:ok, binario}-> :erlang.binary_to_term binario
      {:error, _erro} -> "Nao foi possivel carregar o arquivo"
    end
  end

  @doc """
    Ao receber `fatura` retorna um array de faturas ordenado
      ## Exemplos
      iex> faturas = Fatura.criar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20])
      iex> Fatura.ordena_fatura(faturas)
      [
        %Fatura.Conta{fatura: "Condominio", vencimento: 5},
        %Fatura.Conta{fatura: "Condominio", vencimento: 10},
        %Fatura.Conta{fatura: "Condominio", vencimento: 20},
        %Fatura.Conta{fatura: "Internet", vencimento: 5},
        %Fatura.Conta{fatura: "Internet", vencimento: 10},
        %Fatura.Conta{fatura: "Internet", vencimento: 20},
        %Fatura.Conta{fatura: "Luz", vencimento: 5},
        %Fatura.Conta{fatura: "Luz", vencimento: 10},
        %Fatura.Conta{fatura: "Luz", vencimento: 20}
      ]
  """

  def ordena_fatura(faturas) do
    Enum.sort(faturas)
  end

  @doc """
    Ao receber `faturas` e um elento de `fatura` retorna se existe ou nao
      ## Exemplos
      iex> faturas = Fatura.criar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20])
      iex> Fatura.fatura_existe?(faturas, %Fatura.Conta{fatura: "Luz", vencimento: 20})
      true
  """

  def fatura_existe?(faturas, fatura) do
    Enum.member?(faturas, fatura)
  end
end
