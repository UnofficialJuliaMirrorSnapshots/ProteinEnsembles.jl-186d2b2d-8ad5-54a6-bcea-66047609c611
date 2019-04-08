# Tests for io.jl


test_pdb_filepath_1 = testfile("1AKE.pdb")
test_dssp_filepath_1 = testfile("4AKE.dssp")
test_pdb_filepath_2 = testfile("1CTR_H.pdb")
test_dssp_filepath_2 = testfile("1CTR.dssp")
test_pocket_points = testfile("1AKE_pocket_points.pdb")
test_ligsite_filepath = testfile("1DVM_pocket_all.pdb")


@testset "IO" begin
    dssps = readdssp(test_dssp_filepath_1)
    @test dssps["21A"] == 'H'
    @test dssps["43A"] == ' '


    atoms = readpdb(test_pdb_filepath_2)
    dssps = readdssp(test_dssp_filepath_2, atoms)
    @test length(dssps) == 142
    @test dssps["75A"] == '-'


    atoms = readpdb(test_pdb_filepath_1)
    @test isa(atoms, Array{Atom,1})
    @test length(atoms) == 3312
    atom = atoms[10]
    @test atom.atom_name == "CA"
    @test atom.res_n == 2
    @test atom.coords[2] == 49.969
    atoms = readpdb(test_pdb_filepath_1, hetatm=true)
    @test length(atoms) == 3804


    @test fixstring("Test string", 4) == "Test"
    @test fixstring('T', 4) == "   T"
    @test fixstring(0.123456, 5) == "0.123"
    @test fixstring(123, 5) == "  123"


    @test spaceatomname("CA", "C") == " CA "
    @test spaceatomname("CAB", "C") == " CAB"
    @test spaceatomname("1HB1", "H") == "1HB1"
    @test spaceatomname("CABA", "C") == "CABA"


    atoms = readpdb(test_pdb_filepath_1)
    # Temp file which is removed at the end
    temp_filepath = tempname()
    writepdb(temp_filepath, atoms)
    test_atoms = readpdb(temp_filepath)
    @test length(test_atoms) == 3312
    atom = test_atoms[10]
    @test atom.atom_name == "CA"
    @test atom.res_n == 2
    @test atom.coords[2] == 49.969
    rm(temp_filepath)


    pock_points = readpocketpoints(test_pocket_points)
    @test length(pock_points) == 18
    @test size(pock_points[2]) == (3,54)
    @test pock_points[6] == [
        37.08   37.08   37.08 ;
        42.827  42.827  43.827;
        31.49   32.49   31.49 ;
    ]


    coords, vols = readligsite(test_ligsite_filepath)
    @test size(coords) == (3,43)
    @test length(vols) == 43
    @test coords[:,5] == [8.863, 28.126, -27.957]
    @test vols[5] == 21


    lines = readpdblines(test_pdb_filepath_1)
    @test length(lines) == 3317
    @test lines[10] == "ATOM     10  CA  ARG A   2      27.437  49.969  37.786  1.00 25.76           C  "
end
