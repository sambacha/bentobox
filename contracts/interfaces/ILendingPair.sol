// SPDX-License-Identifier: MIT
// solhint-disable func-name-mixedcase

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;
import "./IOracle.sol";
import "./ISwapper.sol";
import "./IBentoBox.sol";

interface ILendingPair {
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event LogAccrue(uint256 accruedAmount, uint256 feeAmount, uint256 rate, uint256 utilization);
    event LogAddAsset(address indexed user, uint256 amount, uint256 fraction);
    event LogAddBorrow(address indexed user, uint256 amount, uint256 fraction);
    event LogAddCollateral(address indexed user, uint256 amount);
    event LogDev(address indexed newDev);
    event LogExchangeRate(uint256 rate);
    event LogFeeTo(address indexed newFeeTo);
    event LogRemoveAsset(address indexed user, uint256 amount, uint256 fraction);
    event LogRemoveBorrow(address indexed user, uint256 amount, uint256 fraction);
    event LogRemoveCollateral(address indexed user, uint256 amount);
    event LogWithdrawFees();
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function accrue() external;

    function accrueInfo()
        external
        view
        returns (
            uint64 interestPerBlock,
            uint64 lastBlockAccrued,
            uint128 feesPendingAmount
        );

    function addAsset(uint256 amount, bool useBento) external payable;

    function addAssetTo(
        uint256 amount,
        address to,
        bool useBento
    ) external payable;

    function addCollateral(uint256 amount, bool useBento) external payable;

    function addCollateralTo(
        uint256 amount,
        address to,
        bool useBento
    ) external payable;

    function allowance(address, address) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool success);

    function asset() external view returns (IERC20);

    function balanceOf(address) external view returns (uint256);

    function batch(bytes[] calldata calls, bool revertOnFail) external payable returns (bool[] memory, bytes[] memory);

    function bentoBox() external view returns (IBentoBox);

    function borrow(
        uint256 amount,
        address to,
        bool useBento
    ) external;

    function claimOwnership() external;

    function collateral() external view returns (IERC20);

    function decimals() external view returns (uint8);

    function dev() external view returns (address);

    function exchangeRate() external view returns (uint256);

    function feeTo() external view returns (address);

    function getInitData(
        IERC20 collateral_,
        IERC20 asset_,
        IOracle oracle_,
        bytes calldata oracleData_
    ) external pure returns (bytes memory data);

    function init(bytes calldata data) external;

    function isSolvent(address user, bool open) external view returns (bool);

    function liquidate(
        address[] calldata users,
        uint256[] calldata borrowFractions,
        address to,
        ISwapper swapper,
        bool open
    ) external;

    function masterContract() external view returns (ILendingPair);

    function name() external view returns (string memory);

    function nonces(address) external view returns (uint256);

    function oracle() external view returns (IOracle);

    function oracleData() external view returns (bytes memory);

    function owner() external view returns (address);

    function peekExchangeRate() external view returns (bool, uint256);

    function pendingOwner() external view returns (address);

    function permit(
        address owner_,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function permitToken(
        IERC20 token,
        address from,
        uint256 amount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function removeAsset(
        uint256 fraction,
        address to,
        bool useBento
    ) external;

    function removeCollateral(
        uint256 amount,
        address to,
        bool useBento
    ) external;

    function renounceOwnership() external;

    function repay(uint256 fraction, bool useBento) external;

    function repayFor(
        uint256 fraction,
        address beneficiary,
        bool useBento
    ) external;

    function setApproval(
        address user,
        bool approved,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function setDev(address newDev) external;

    function setFeeTo(address newFeeTo) external;

    function setSwapper(ISwapper swapper, bool enable) external;

    function short(
        ISwapper swapper,
        uint256 assetAmount,
        uint256 minCollateralAmount
    ) external;

    function swappers(ISwapper) external view returns (bool);

    function swipe(IERC20 token) external;

    function symbol() external view returns (string memory);

    function totalAsset() external view returns (uint128 amount, uint128 fraction);

    function totalBorrow() external view returns (uint128 amount, uint128 fraction);

    function totalCollateralAmount() external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool success);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool success);

    function transferOwnership(address newOwner) external;

    function transferOwnershipDirect(address newOwner) external;

    function unwind(
        ISwapper swapper,
        uint256 borrowFraction,
        uint256 maxAmountCollateral
    ) external;

    function updateExchangeRate() external returns (uint256);

    function userBorrowFraction(address) external view returns (uint256);

    function userCollateralAmount(address) external view returns (uint256);

    function withdrawFees() external;
}
