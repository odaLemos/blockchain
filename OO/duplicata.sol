// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.19;

import "./titulo.sol";
import "./owner.sol";

//Contrato de Titulo - Duplicata: 0x84A56503aaEf99bf1e8ac754CA6B541329Bdd5ae

/**
 * @title Titulo
 * @dev Define Operacoes de uma duplicata
 * @author odair Lemos
 */

contract Duplicata is Titulo, Owner {
    string _emissor;
    uint256 immutable _dataEmissao;
    uint256 _valorTotalDivida;
    uint256 _prazoPagamento;
    uint256 _numeroOrdem;
    uint256 _numeroFatura;
    

    constructor() {
        _emissor = "XPTO Comercio de brinquedos LTDA";
        _dataEmissao = block.timestamp;
        _valorTotalDivida = 100050000;
        _numeroOrdem = 2345456;
        _numeroFatura = 5349848;
        _prazoPagamento = _dataEmissao + 30 days;
        emit NovoPrazoPagamento(_dataEmissao, _prazoPagamento);
    }

    /**
     * @dev Retorna o valor nominal.
     */
    function valorNominal() external view returns (uint256) {
        return _valorTotalDivida;
    }

    /**
     * @dev Retorna o nome do Emissor.
     */
    function nomeEmissor() external view returns (string memory) {
        return _emissor;
    }

    /**
     * @dev Retorna a data da emissao.
     */
    function dataEmissao() external view returns (uint256) {
        return _dataEmissao;
    }

    /**
    * @dev muda o prazo de pagamento
    * @notice dependendo da situacao economica o prazo de pagamento pode mudar
    * @param prazoPagamento_ novo prazo de pagamentos a ser adicionado. Em segundos
    */
    function mudaDataPagamento(uint256 prazoPagamento_) external onlyOwner returns (uint256) {
        emit NovoPrazoPagamento(_prazoPagamento, _prazoPagamento + prazoPagamento_);
        _prazoPagamento = _prazoPagamento + prazoPagamento_;
        return _prazoPagamento;
    }
}