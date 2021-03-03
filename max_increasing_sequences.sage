def max_increasing_sequences1(perm):
    r'''
    Return the list of the longest increasing subsequences of ``perm``
    
    A theorem of Schensted ([ADD IN REFERENCES]) states that an
    increasing subsequence of length `i` ends with the value entered in
    the `i`-th column of the p-tableau. The algorithm records which
    column of the p-tableau each value of the permutation is entered
    into, and computes all possible combinations of one entry from each
    column. The algorithm then checks if the combination is an
    increasing sequence.
    
    EXAMPLES::
    
        sage: max_increasing_sequences1(Permutation([4,1,7,8,2,3,9,5,6]))
        [[1,2,3,5,6]]
        sage: max_increasing_sequences1(Permutation([7,3,4,5,9,2,8,1,6])
        [[3,4,5,9], [3,4,5,8], [3,4,5,6]]
    
    '''
    
    
    def is_subsequence_of(seq1, perm):
        r"""
        Returns whether seq1 is a subsequence of permutation perm
        """
        
        j = 0
        seq2 = []
        while j<len(seq1)-1:
            if perm.index(seq1[j]) < perm.index(seq1[j+1]):
                j = j+1
            else:
                return False
        return True


    n = perm.size()
    
    # getting the column in which each element is inserted
    first_row_p_tableau = []
    column = []
    for i in range(n):
        inserted = False
        j = 0  # j is j-th column of p-tableau
        while j < len(first_row_p_tableau) and not inserted:
            if first_row_p_tableau[j] > perm[i]:
                first_row_p_tableau[j] = perm[i]
                column.append(j)
                inserted = True
            j = j+1
        if not inserted:
            first_row_p_tableau.append(perm[i])
            column.append(j)
            
    # getting the sets for columns
    s = [[] for i in range(len(first_row_p_tableau))]
    for i in range(n):
        s[column[i]].append(perm[i])
    increasing_sequences = []
    
    # getting the increasing sequences
    import itertools
    potential_sequences = list(itertools.product(*s))
    for seq in potential_sequences:
        seq = list(seq)
        if seq == sorted(seq) and is_subsequence_of(seq, perm):
            increasing_sequences.append(seq)
    return increasing_sequences

