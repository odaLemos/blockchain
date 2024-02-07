/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/
pragma solidity 0.8.19;

// @author Odair Lemos
// @title Exemplod e Faucet
contract Aluguel {

    mapping(address=>uint256) public ultimaAtribuicao;
    mapping(address=>uint8) public atribuicoes;
    uint8 valorASerAtribuido;
    


    function atribuirValor() public returns (uint256) {
        require(ultimaAtribuicao[msg.sender]+100 <= block.timestamp, "Sinto muito. Voce ja usou o faucet");
        require(valorASerAtribuido < 256, "Sinto muito. Voce perdeu sua chance");
        valorASerAtribuido++;
        ultimaAtribuicao[msg.sender] = block.timestamp;
        atribuicoes[msg.sender] = valorASerAtribuido;
        return valorASerAtribuido;
    }
}