/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Odair Lemos Rodrigues
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/
pragma solidity 0.8.19;

//ENDEREÇO DO CONTRATO PUBLICADO: 0xA9BAd2fe69d88C73c9391C7f7a358EEc9f59eBD0

// @author Odair Lemos
// @title Vaquinha solidária
// @dev Exercicio de Map, NatSpec e event.
// @notice Contrato com o objetivo de arrecadar wei para caridade.
contract Vaquinha {

    mapping(uint256 valor => string nome) private doacoes;
    uint256 private valorArrecadado = 0;
    uint256 private meta = 1000;
    uint256 private maiorValorArrecadado = 0;
    address public owner;

    event Doacao(address identificador, uint256 valorDoado);
    event MetaAtingida(uint256 valorTotalArrecadado);

    constructor() {
        owner = msg.sender;
    }

    // @notice Metodo responsável por gerenciar as doações, onde não deve aceitar doações após a meta atingida.
    // @dev metodo verifica valor arrecadado, limite de doações e armazena quem foi o maior doador.
    function doarValor(string memory nomeDoador, address payable addressDoador ) public payable {
        
        require(campanhaAtiva(), "A campanha esta encerrada, meta atingida.");
        
        uint256 valorDoado = msg.value;
        doacoes[valorDoado] = nomeDoador;

        addressDoador.transfer(valorDoado);
        
        valorArrecadado += valorDoado;
        atualizarMaiorDoador();

        emit Doacao(addressDoador, valorDoado);

        if (metaAtingida()) {
            emit MetaAtingida(valorArrecadado);
        } 

    }

    //@notice retorna quem foi o maior doador após atingir a meta.
    function maiorDoador() public view returns (string memory) {
        require(metaAtingida(), "A campanha ainda esta em andamento!");
        return doacoes[maiorValorArrecadado];
    }

    //@dev atualiza de quem é o maior doador
    function atualizarMaiorDoador() private {
        if (msg.value > maiorValorArrecadado) {
            maiorValorArrecadado = msg.value;
        }
    }

    //@dev verifica se a campanha ainda está ativa
    function campanhaAtiva() private view returns (bool) {
        return (valorArrecadado < meta);
    }

    //@dev verifica se a meta foi atinjida
    function metaAtingida() private view returns (bool) {
        return (valorArrecadado >= meta);
    }

    //@dev atribui novo valor ao parametro de meta
    //@notice metodo que ajusta o valor da meta usado para fins de desenvolvimento
    function ajustarMeta(uint256 novaMeta) public {
        meta = novaMeta;
    }
}