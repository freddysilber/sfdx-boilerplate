List<List<Integer>> data = new List<List<Integer>>{
    new List<Integer>{1, 200},
    new List<Integer>{10, 20},
    new List<Integer>{1, 100},
    new List<Integer>{10, 100},
    new List<Integer>{100, 10},
    new List<Integer>{1, 1500},
    new List<Integer>{10, 150},
    new List<Integer>{10, 250},
    new List<Integer>{10, 500}
};

ProjectSeedingBatch psb;
for (List<Integer> d : data) {
    psb = new ProjectSeedingBatch( (d[0] * d[1]) + ' total tasks (' + d[1] + ' phases) no deps, short', d[0], d[1], false, false);
    database.executeBatch(psb, 500);
    psb = new ProjectSeedingBatch( (d[0] * d[1]) + ' total tasks (' + d[1] + ' phases) deps, short', d[0], d[1], true, false);
    database.executeBatch(psb, 200);
    psb = new ProjectSeedingBatch( (d[0] * d[1]) + ' total tasks (' + d[1] + ' phases) deps, long', d[0], d[1], true, true);
    database.executeBatch(psb, 200);
}