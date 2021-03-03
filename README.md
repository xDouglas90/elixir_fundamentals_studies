## Estudo dos Fundamentos basicos de Elixir
Mini projeto com intuito de estudo dos fundamentos basicos da linguagem funcional Elixir.

 ## Funções
 ###criar_faturas
   Ao receber `fatura` e `vencimento` retorna um array de faturas
```elixir
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
```
### pagar_faturas
  Ao receber dados para gerar fatura, deve ordenar e salvar em um arquivo binario.
```elixir
        iex> Fatura.pagar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20], 1, "pagar")
        :ok
```

### faturas_a_pagar
   Ao receber o `nome_arquivo` e `faturas`, salva em arquivo binario e retorna :ok.
```elixir
        iex> faturas = Fatura.criar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20])
        iex> Fatura.save(faturas, "file")
        :ok
```

### save
   Ao receber o `nome_arquivo` e `faturas`, salva em arquivo binario e retorna :ok.
```elixir
        iex> faturas = Fatura.criar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20])
        iex> Fatura.save(faturas, "file")
        :ok
```
### load
   Ao receber `nome_arquivo`, retorna o seu conteudo.
```elixir
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
```
### ordena_fatura
   Ao receber `fatura` retorna um array de faturas ordenado
```elixir
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
```
### fatura_existe?
  Ao receber `faturas` e um elento de `fatura` retorna se existe ou nao
```elixir
        iex> faturas = Fatura.criar_faturas(["Internet", "Luz", "Condominio"], [5, 10, 20])
        iex> Fatura.fatura_existe?(faturas, %Fatura.Conta{fatura: "Luz", vencimento: 20})
        true
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fatura` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fatura, "~> 0.1.0"}
  ]
end
```

