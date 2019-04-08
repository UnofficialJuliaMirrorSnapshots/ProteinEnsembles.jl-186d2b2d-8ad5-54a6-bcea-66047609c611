# Tests for types.jl


@testset "Types" begin
    # Test type constructors
    bonded_pair = BondedPair("ALA", "CA", "C")
    @test isa(bonded_pair, BondedPair)
    show(devnull, bonded_pair)

    atom = Atom("CA", "ALA", 'A', 100, [1.0, 2.0, 3.0], "C")
    @test isa(atom, Atom)
    show(devnull, atom)

    atoms = [
        Atom("CA", "ALA", 'A', 100, [1.0, 2.0, 3.0], "C"),
        Atom("CA", "LEU", 'A', 101, [1.0, 2.0, 3.0], "C"),
        Atom("CA", "VAL", 'A', 102, [1.0, 2.0, 3.0], "C")
    ]
    constraints = Constraints(
        atoms,
        [1.0, 2.0],
        [1.5, 2.5],
        [1 2; 2 3]
    )
    @test isa(constraints, Constraints)
    show(devnull, constraints)

    struc = ModelledStructure(
        1.0, [
            1.0 1.0 1.0;
            1.0 1.0 1.0;
            1.0 1.0 1.0;
        ]
    )
    @test isa(struc, ModelledStructure)
    show(devnull, struc)

    ens = ModelledEnsemble(atoms, [struc])
    @test isa(ens, ModelledEnsemble)
    show(devnull, ens)
    ens = ModelledEnsemble(atoms)
    @test isa(ens, ModelledEnsemble)
    show(devnull, ens)

    evals = [1.0, 2.0, 3.0]
    evecs = [
        1.0 1.0 1.0;
        1.0 1.0 1.0;
        1.0 1.0 1.0;
        1.0 1.0 1.0;
        1.0 1.0 1.0;
        1.0 1.0 1.0;
        1.0 1.0 1.0;
        1.0 1.0 1.0;
        1.0 1.0 1.0;
    ]
    av_coords = [
        1.0 1.0 1.0;
        1.0 1.0 1.0;
        1.0 1.0 1.0;
    ]
    pcs = [
        1.0 1.0 1.0 1.0;
        1.0 1.0 1.0 1.0;
        1.0 1.0 1.0 1.0;
    ]
    pca = PCA(evals, evecs, av_coords, pcs)
    @test isa(pca, PCA)
    show(devnull, pca)
    pca = PCA(evals, evecs, av_coords)
    @test isa(pca, PCA)
    show(devnull, pca)
end
