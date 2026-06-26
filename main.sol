// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

/// @title WC2026AI — north-star fixture lattice with AI attest lanes.
/// @dev codename: azteca pulse / group bracket echo seven

library Wc26Pack {
    error WC26_PackOverflow();
    uint256 internal constant BPS = 10_000;
    function clampU16(uint256 v, uint16 lo, uint16 hi) internal pure returns (uint16) {
        if (v < lo) return lo;
        if (v > hi) return hi;
        return uint16(v);
    }
    function takeBps(uint256 gross, uint256 bps) internal pure returns (uint256) {
        unchecked { return (gross * bps) / BPS; }
    }
    function safeAdd(uint256 a, uint256 b, uint256 cap) internal pure returns (uint256) {
        unchecked {
            uint256 s = a + b;
            if (s < a || s > cap) revert WC26_PackOverflow();
            return s;
        }
    }
    function splitDigest(bytes32 a, bytes32 b, uint64 kickoff) internal pure returns (bytes32) {
        bytes32 hA = keccak256(abi.encode(a, kickoff));
        bytes32 hB = keccak256(abi.encode(b, kickoff ^ uint64(0xC026)));
        return keccak256(abi.encodePacked(hA, hB));
    }
}

contract WC2026AI {
    error WC26_NotPitMaster();
    error WC26_NotLinesman();
    error WC26_NotOracle();
    error WC26_LanePaused();
    error WC26_TournamentOff();
    error WC26_ZeroAddr();
    error WC26_Reentered();
    error WC26_GroupUnknown();
    error WC26_GroupSealed();
    error WC26_GroupFull();
    error WC26_FixtureMissing();
    error WC26_FixtureSealed();
    error WC26_FixtureLive();
    error WC26_FixtureDone();
    error WC26_SquadTaken();
    error WC26_SquadEmpty();
    error WC26_NotCoach();
    error WC26_AlreadyRevealed();
    error WC26_RevealEarly();
    error WC26_RevealMismatch();
    error WC26_PredictSpent();
    error WC26_ScoreLow();
    error WC26_ScoreHigh();
    error WC26_OracleStale();
    error WC26_CallCap();
    error WC26_BatchEmpty();
    error WC26_BatchWide();
    error WC26_SizeMismatch();
    error WC26_NoPending();
    error WC26_PendingSet();
    error WC26_SelfRoute();
    error WC26_AttestDone();
    error WC26_Fault_32();
    error WC26_Fault_33();
    error WC26_Fault_34();
    error WC26_Fault_35();
    error WC26_Fault_36();
    error WC26_Fault_37();
    error WC26_Fault_38();
    error WC26_Fault_39();
    error WC26_Fault_40();
    error WC26_Fault_41();
    error WC26_Fault_42();
    error WC26_Fault_43();
    error WC26_Fault_44();
    error WC26_Fault_45();
    error WC26_Fault_46();
    error WC26_Fault_47();
    error WC26_Fault_48();
    error WC26_Fault_49();
    error WC26_Fault_50();
    error WC26_Fault_51();
    error WC26_Fault_52();

    event Opened(uint32 indexed groupId, uint16 cap, uint64 at, uint256 meta);
    event Sealed(uint32 indexed groupId, uint16 filled, uint64 at);
    event Claimed(uint32 indexed fixtureId, address indexed coach, bytes32 squadTag, uint64 kickoff);
    event Committed(uint32 indexed fixtureId, uint16 indexed slotId, address indexed coach, bytes32 commitment, uint64 revealAfter);
    event Revealed(uint32 indexed fixtureId, uint16 indexed slotId, address indexed coach, bytes32 preimage, uint64 at);
    event Attested(uint32 indexed fixtureId, bytes32 aiDigest, uint16 homeScore, uint16 awayScore, uint64 at);
    event Voted(bytes32 indexed ballotId, address indexed voter, bool up, uint32 epochId, uint256 weight);
    event TournamentSet(bool live, uint64 at);
    event LanePauseSet(bool paused, uint64 at);
    event PitMasterProposed(address indexed next);
    event PitMasterAccepted(address indexed pitMaster, uint64 at);
    event Echo_0(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_1(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_2(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_3(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_4(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_5(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_6(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_7(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_8(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_9(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_10(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);
    event Echo_11(uint256 indexed serial, address indexed caller, uint256 meta, uint32 epoch);

    enum GroupPhase {
        Dormant,
        Open,
        Sealed
    }

    enum FixtureStage {
        Waiting,
        Live,
        Finalized,
        Voided
    }

    enum SquadState {
        Empty,
        Reserved,
        Locked
    }

    bytes32 private constant _SEED_0 = 0x437271478bb922d7a14c33858d43f186a777c105e9c779e851f969f189a4add9;
    bytes32 private constant _SEED_1 = 0x39fd3e393491cd7c35c2fb87567115ac567121e82936f706685e957595d99493;
    bytes32 private constant _SEED_2 = 0x4695d5f2262c3effc920cd4ac7e2ffddb25d8cd7d0cad2788d6e876bdcc7c813;
    bytes32 private constant _SEED_3 = 0x162b1fd7e42b90de4da4f327f7364b404ba5e8d61b5d27d3eeeb9bad51f7ada8;
    bytes32 private constant _SEED_4 = 0x20dadd1a30f3e841c6bdb5eb67d452de8793232d4884dc3d42d385c9209bc374;
    bytes32 private constant _SEED_5 = 0x2026986acfbfae26af963a63e37b33b6354bb2405284ef89cfc6bc5767bf6f29;
    bytes32 private constant _SEED_6 = 0x4f302528dbc5a3abece4a5ce372c1846351b034f374702dd3bd9f56f95b508ba;
    bytes32 private constant _SEED_7 = 0x4b8e0443151941b265527ea46a29623ae934682d676c4ddf486cdb7a2f791d30;
    bytes32 private constant _SEED_8 = 0xb2f9e451909150c7e5e04f3f9618753597c7b65751c1d168f5180fe0e21bb6aa;
    address private constant ADDRESS_A = 0x799E840CaeCE6F1a07F140fCcED507a9515DaBB5;
    address private constant ADDRESS_B = 0xF605AE140E39934bA6F6Fb689716d73188f3388A;
    address private constant ADDRESS_C = 0x55c38204BE46807960B62461dfa8e12C9A947ac8;

    uint16 public constant MAX_SQUAD_SLOTS = 28;
    uint32 public constant MAX_FIXTURES = 108;
    uint32 public constant MAX_OPEN_CALLS = 46;
    uint64 public constant REVEAL_LAG = 9682;
    uint16 public constant GROUP_CAP = 8;
    uint256 public constant MATCH_FEE = 1135;
    uint256 public constant EPOCH_SPAN = 797;
    uint16 public constant SCORE_FLOOR = 274;
    uint16 public constant SCORE_CEIL = 6789;
    uint256 public constant VERSION = 700;

    address public pitMaster;
    address public pendingPitMaster;
    address public immutable linesmanSeat;
    address public immutable oracleSeat;
    address public immutable stadiumSeat;

    bool public tournamentLive;
    bool public lanePaused;
    uint32 public activeEpoch;
    uint32 public openCallCount;
    uint32 public fixtureSerial;
    uint64 public openedAt;
    uint256 public echoSerial;
    uint256 private _lock;

    struct GroupRow {
        bytes32 bandTag;
        uint16 cap;
        uint16 filled;
        GroupPhase phase;
        uint64 openedAt;
    }

    struct FixtureRow {
        uint32 groupId;
        bytes32 homeTag;
        bytes32 awayTag;
        bytes32 aiDigest;
        uint16 homeScore;
        uint16 awayScore;
        FixtureStage stage;
        uint64 kickoff;
        uint64 attestedAt;
        bool attested;
    }

    struct SquadSlot {
        address coach;
        bytes32 squadTag;
        bytes32 commitment;
        bytes32 preimage;
        uint64 revealAfter;
        SquadState state;
        bool revealed;
    }

    struct CoachBench {
        bool active;
        bytes32 crest;
        uint32 fixtureCount;
    }

    mapping(uint32 => GroupRow) public groups;
    mapping(uint32 => FixtureRow) public fixtures;
    mapping(uint32 => mapping(uint16 => SquadSlot)) private _slots;
    mapping(uint32 => mapping(address => uint16[])) private _coachSlots;
    mapping(address => CoachBench) public coachBenches;
    mapping(bytes32 => bool) public ballotSpent;
    mapping(bytes32 => uint256) public ballotUp;
    mapping(bytes32 => uint256) public ballotDown;
    mapping(uint32 => mapping(address => bool)) public predictSpent;

    modifier nonReentrant() {
        if (_lock == 1) revert WC26_Reentered();
        _lock = 1;
        _;
        _lock = 0;
    }

    modifier onlyPitMaster() {
        if (msg.sender != pitMaster) revert WC26_NotPitMaster();
        _;
    }

    modifier onlyLinesman() {
        if (msg.sender != linesmanSeat) revert WC26_NotLinesman();
        _;
    }

    modifier onlyOracle() {
        if (msg.sender != oracleSeat) revert WC26_NotOracle();
        _;
    }

    modifier whenLive() {
        if (!tournamentLive) revert WC26_TournamentOff();
        if (lanePaused) revert WC26_LanePaused();
        _;
    }

    constructor() {
        pitMaster = msg.sender;
        linesmanSeat = ADDRESS_A;
        oracleSeat = ADDRESS_B;
        stadiumSeat = ADDRESS_C;
        openedAt = uint64(block.timestamp);
        activeEpoch = 1;
    }

    function setTournamentLive(bool live) external onlyPitMaster {
        tournamentLive = live;
        emit TournamentSet(live, uint64(block.timestamp));
    }

    function setLanePaused(bool paused) external onlyPitMaster {
        lanePaused = paused;
        emit LanePauseSet(paused, uint64(block.timestamp));
    }

    function proposePitMaster(address next) external onlyPitMaster {
        if (next == address(0)) revert WC26_ZeroAddr();
        pendingPitMaster = next;
        emit PitMasterProposed(next);
    }

    function acceptPitMaster() external {
        if (msg.sender != pendingPitMaster) revert WC26_NoPending();
        pitMaster = msg.sender;
        pendingPitMaster = address(0);
        emit PitMasterAccepted(msg.sender, uint64(block.timestamp));
    }

    function bumpEpoch() external onlyPitMaster {
        unchecked { activeEpoch += 1; }
    }

    function openGroup(uint32 groupId, bytes32 bandTag, uint16 cap) public onlyPitMaster {
        GroupRow storage g = groups[groupId];
        if (g.phase != GroupPhase.Dormant) revert WC26_GroupSealed();
        if (cap == 0 || cap > GROUP_CAP) revert WC26_GroupFull();
        g.bandTag = bandTag;
        g.cap = cap;
        g.phase = GroupPhase.Open;
        g.openedAt = uint64(block.timestamp);
        emit Opened(groupId, cap, g.openedAt, uint256(bandTag));
    }

    function sealGroup(uint32 groupId) public onlyPitMaster {
        GroupRow storage g = groups[groupId];
        if (g.phase != GroupPhase.Open) revert WC26_GroupUnknown();
        g.phase = GroupPhase.Sealed;
        emit Sealed(groupId, g.filled, uint64(block.timestamp));
    }

    function scheduleFixture(
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint64 kickoff
    ) external onlyLinesman whenLive returns (uint32 fixtureId) {
        GroupRow storage g = groups[groupId];
        if (g.phase != GroupPhase.Open && g.phase != GroupPhase.Sealed) revert WC26_GroupUnknown();
        if (fixtureSerial >= MAX_FIXTURES) revert WC26_CallCap();
        unchecked { fixtureId = fixtureSerial + 1; fixtureSerial = fixtureId; }
        FixtureRow storage f = fixtures[fixtureId];
        f.groupId = groupId;
        f.homeTag = homeTag;
        f.awayTag = awayTag;
        f.kickoff = kickoff;
        f.stage = FixtureStage.Waiting;
        unchecked { g.filled += 1; }
    }

    function kickFixture(uint32 fixtureId) external onlyLinesman whenLive {
        FixtureRow storage f = fixtures[fixtureId];
        if (f.stage != FixtureStage.Waiting) revert WC26_FixtureLive();
        f.stage = FixtureStage.Live;
        if (openCallCount >= MAX_OPEN_CALLS) revert WC26_CallCap();
        unchecked { openCallCount += 1; }
    }

    function voidFixture(uint32 fixtureId) external onlyPitMaster {
        FixtureRow storage f = fixtures[fixtureId];
        if (f.stage == FixtureStage.Finalized) revert WC26_FixtureDone();
        f.stage = FixtureStage.Voided;
        if (openCallCount > 0) unchecked { openCallCount -= 1; }
    }

    function claimSquad(uint32 fixtureId, uint16 slotId, bytes32 squadTag) external whenLive nonReentrant {
        FixtureRow storage f = fixtures[fixtureId];
        if (f.stage != FixtureStage.Waiting && f.stage != FixtureStage.Live) revert WC26_FixtureSealed();
        if (slotId >= MAX_SQUAD_SLOTS) revert WC26_SquadEmpty();
        SquadSlot storage s = _slots[fixtureId][slotId];
        if (s.state != SquadState.Empty) revert WC26_SquadTaken();
        s.coach = msg.sender;
        s.squadTag = squadTag;
        s.state = SquadState.Reserved;
        _coachSlots[fixtureId][msg.sender].push(slotId);
        CoachBench storage cb = coachBenches[msg.sender];
        cb.active = true;
        unchecked { cb.fixtureCount += 1; }
        emit Claimed(fixtureId, msg.sender, squadTag, f.kickoff);
    }

    function commitPredict(uint32 fixtureId, uint16 slotId, bytes32 commitment) external whenLive {
        SquadSlot storage s = _slots[fixtureId][slotId];
        if (s.coach != msg.sender) revert WC26_NotCoach();
        if (s.state != SquadState.Reserved) revert WC26_SquadTaken();
        if (commitment == bytes32(0)) revert WC26_RevealMismatch();
        s.commitment = commitment;
        s.revealAfter = uint64(block.timestamp) + REVEAL_LAG;
        s.state = SquadState.Locked;
        emit Committed(fixtureId, slotId, msg.sender, commitment, s.revealAfter);
    }

    function revealPredict(uint32 fixtureId, uint16 slotId, bytes32 preimage) external whenLive {
        SquadSlot storage s = _slots[fixtureId][slotId];
        if (s.coach != msg.sender) revert WC26_NotCoach();
        if (s.state != SquadState.Locked) revert WC26_SquadEmpty();
        if (s.revealed) revert WC26_AlreadyRevealed();
        if (block.timestamp < s.revealAfter) revert WC26_RevealEarly();
        if (keccak256(abi.encodePacked(preimage)) != s.commitment) revert WC26_RevealMismatch();
        s.preimage = preimage;
        s.revealed = true;
        emit Revealed(fixtureId, slotId, msg.sender, preimage, uint64(block.timestamp));
    }

    function attestScore(
        uint32 fixtureId,
        uint16 homeScore,
        uint16 awayScore,
        bytes32 modelTag
    ) external onlyOracle whenLive {
        FixtureRow storage f = fixtures[fixtureId];
        if (f.stage != FixtureStage.Live) revert WC26_FixtureMissing();
        if (f.attested) revert WC26_AttestDone();
        if (homeScore < SCORE_FLOOR || awayScore < SCORE_FLOOR) revert WC26_ScoreLow();
        if (homeScore > SCORE_CEIL || awayScore > SCORE_CEIL) revert WC26_ScoreHigh();
        f.homeScore = homeScore;
        f.awayScore = awayScore;
        f.aiDigest = Wc26Pack.splitDigest(f.homeTag, f.awayTag, f.kickoff ^ uint64(uint256(modelTag)));
        f.attested = true;
        f.attestedAt = uint64(block.timestamp);
        f.stage = FixtureStage.Finalized;
        if (openCallCount > 0) unchecked { openCallCount -= 1; }
        emit Attested(fixtureId, f.aiDigest, homeScore, awayScore, f.attestedAt);
    }

    function castBallot(bytes32 ballotId, bool up, uint256 weight) external whenLive {
        if (ballotSpent[ballotId]) revert WC26_PredictSpent();
        ballotSpent[ballotId] = true;
        if (up) ballotUp[ballotId] += weight;
        else ballotDown[ballotId] += weight;
        emit Voted(ballotId, msg.sender, up, activeEpoch, weight);
    }

    function rosterDigest(uint32 fixtureId) external view returns (bytes32) {
        FixtureRow storage f = fixtures[fixtureId];
        return Wc26Pack.splitDigest(f.homeTag, f.awayTag, f.kickoff);
    }

    function coachSlotList(uint32 fixtureId, address coach) external view returns (uint16[] memory) {
        return _coachSlots[fixtureId][coach];
    }

    function ballotTally(bytes32 ballotId) external view returns (uint256 up, uint256 down) {
        return (ballotUp[ballotId], ballotDown[ballotId]);
    }

    function epochWindow() external view returns (uint32 epoch, uint256 span) {
        return (activeEpoch, EPOCH_SPAN);
    }

    function bootGroup_A_0() external onlyPitMaster {
        openGroup(1, keccak256(abi.encode(_SEED_0, uint256(1))), 8);
    }

    function bootGroup_B_1() external onlyPitMaster {
        openGroup(2, keccak256(abi.encode(_SEED_1, uint256(2))), 7);
    }

    function bootGroup_C_2() external onlyPitMaster {
        openGroup(3, keccak256(abi.encode(_SEED_2, uint256(3))), 6);
    }

    function bootGroup_D_3() external onlyPitMaster {
        openGroup(4, keccak256(abi.encode(_SEED_3, uint256(4))), 8);
    }

    function bootGroup_E_4() external onlyPitMaster {
        openGroup(5, keccak256(abi.encode(_SEED_4, uint256(5))), 7);
    }

    function bootGroup_F_5() external onlyPitMaster {
        openGroup(6, keccak256(abi.encode(_SEED_5, uint256(6))), 6);
    }

    function bootGroup_G_6() external onlyPitMaster {
        openGroup(7, keccak256(abi.encode(_SEED_6, uint256(7))), 8);
    }

    function bootGroup_H_7() external onlyPitMaster {
        openGroup(8, keccak256(abi.encode(_SEED_7, uint256(8))), 7);
    }

    function bootGroup_I_8() external onlyPitMaster {
        openGroup(9, keccak256(abi.encode(_SEED_8, uint256(9))), 6);
    }

    function bootGroup_J_9() external onlyPitMaster {
        openGroup(10, keccak256(abi.encode(_SEED_0, uint256(10))), 8);
    }

    function bootGroup_K_10() external onlyPitMaster {
        openGroup(11, keccak256(abi.encode(_SEED_1, uint256(11))), 7);
    }

    function readFixture_0(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_1(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_2(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_3(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_4(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_5(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_6(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_7(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_8(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_9(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_10(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_11(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_12(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_13(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_14(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_15(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_16(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_17(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_18(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_19(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_20(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_21(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_22(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_23(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_24(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_25(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_26(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_27(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_28(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_29(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_30(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_31(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_32(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
        awayTag = f.awayTag;
        homeScore = f.homeScore;
        awayScore = f.awayScore;
        stage = f.stage;
        attested = f.attested;
    }

    function readFixture_33(uint32 fixtureId) external view returns (
        uint32 groupId,
        bytes32 homeTag,
        bytes32 awayTag,
        uint16 homeScore,
        uint16 awayScore,
        FixtureStage stage,
        bool attested
    ) {
        FixtureRow storage f = fixtures[fixtureId];
        groupId = f.groupId;
        homeTag = f.homeTag;
