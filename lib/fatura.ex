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

  @doc """
    Ao receber dados para gerar fatura, deve ordenar e salvar em um arquivo binario.
      ## Exemplos
        iex> Fatura.pagar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20], 1, "pagar")
        :ok
  """

  def pagar_faturas(faturas, vencimento, quantidade, nome_arquivo) do
    criar_faturas(faturas, vencimento)
    |> ordena_fatura
    |> faturas_a_pagar(quantidade)
    |> save(nome_arquivo)
  end

  @doc """
    Ao passar `faturas` e `quantidade`, retorna a quantidade informada de elementos de `faturas`.
      ## Exemplos
        iex> faturas = Fatura.criar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20])
        iex> Fatura.faturas_a_pagar(faturas, 2)
        {[
          %Fatura.Conta{fatura: "Internet", vencimento: 5},
          %Fatura.Conta{fatura: "Luz", vencimento: 5}
        ],
        [
          %Fatura.Conta{fatura: "Condominio", vencimento: 5},
          %Fatura.Conta{fatura: "Internet", vencimento: 10},
          %Fatura.Conta{fatura: "Luz", vencimento: 10},
          %Fatura.Conta{fatura: "Condominio", vencimento: 10},
          %Fatura.Conta{fatura: "Internet", vencimento: 20},
          %Fatura.Conta{fatura: "Luz", vencimento: 20},
          %Fatura.Conta{fatura: "Condominio", vencimento: 20}
        ]}
  """

  def faturas_a_pagar(faturas, quantidade) do
    Enum.split(faturas, quantidade)
  end

  @doc """
    Ao receber o `nome_arquivo` e `faturas`, salva em arquivo binario e retorna :ok.
      ## Exemplos
        iex> faturas = Fatura.criar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20])
        iex> Fatura.save(faturas, "file")
        :ok
  """

  def save(faturas, nome_arquivo) do
    binary = :erlang.term_to_binary(faturas)
    File.write(nome_arquivo, binary)
  end

  @doc """
    Ao receber `nome_arquivo`, retorna o seu conteudo.
      ## Exemplos
        iex> faturas = Fatura.criar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20])
        iex> Fatura.save(faturas, "file")
        iex> Fatura.load("file")
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
