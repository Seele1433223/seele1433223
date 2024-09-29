module 0x1::governance {
    struct Proposal has store {
        id: u64,
        description: vector<u8>,
        votes_for: u64,
        votes_against: u64,
        status: ProposalStatus,
    }

    enum ProposalStatus {
        Pending,
        Accepted,
        Rejected,
    }

    struct Governance has store {
        proposals: vector<Proposal>,
    }

    public fun initialize() {
        let governance = Governance { proposals: vec[] };
        move_to(@signer, governance);
    }

    public fun create_proposal(description: vector<u8>) {
        let governance = borrow_global_mut<Governance>(@signer);
        let proposal_id = vector_length(governance.proposals);
        let new_proposal = Proposal {
            id: proposal_id,
            description,
            votes_for: 0,
            votes_against: 0,
            status: ProposalStatus::Pending,
        };
        governance.proposals.push(new_proposal);
    }

    public fun vote(proposal_id: u64, in_favor: bool) {
        let governance = borrow_global_mut<Governance>(@signer);
        assert!(proposal_id < vector_length(governance.proposals), 0);
        
        let proposal = &mut governance.proposals[proposal_id];
        
        if (in_favor) {
            proposal.votes_for = proposal.votes_for + 1;
        } else {
            proposal.votes_against = proposal.votes_against + 1;
        }

        // 简单的投票逻辑：如果支持票数超过反对票，提案通过
        if (proposal.votes_for > proposal.votes_against) {
            proposal.status = ProposalStatus::Accepted;
        } else if (proposal.votes_against > proposal.votes_for) {
            proposal.status = ProposalStatus::Rejected;
        }
    }

    public fun get_proposal(owner: address, id: u64): Proposal {
        let governance = borrow_global<Governance>(owner);
        assert!(id < vector_length(governance.proposals), 0);
        let proposal = &governance.proposals[id];
        proposal
    }
}
