def max_increasing_sequences1(perm):
    r'''
    Return the list of the longest increasing subsequences of ``perm``
    
    EXAMPLES::
    
        sage: max_increasing_sequences1(Permutation([4,1,7,8,2,3,9,5,6]))
        [[1,2,3,5,6]]
        sage: max_increasing_sequences1(Permutation([7,3,4,5,9,2,8,1,6])
        [[3,4,5,9], [3,4,5,8], [3,4,5,6]]
    
    '''
    
    
    def is_subsequence_of(seq1,perm):
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
    
    first_row_p_tableau = []
    column = []
    for i in range(n):
        inserted = False
        j = 0
        #  j is j-th column of p-tableau
        while j < len(first_row_p_tableau) and not inserted:
            if first_row_p_tableau[j] > perm[i]:
                first_row_p_tableau[j] = perm[i]
                column.append(j)
                inserted = True
            j = j+1
        if not inserted:
            first_row_p_tableau.append(perm[i])
            column.append(j)
    s = [[] for i in range(len(first_row_p_tableau)]
    #  entry i is list of elements added to i-th column of p-tableau
    for i in range(n):
        s[column[i]].append(perm[i])
    increasing_sequences = []
    
    import itertools
    potential_sequences = list(itertools.product(*s))
    for seq in potential_sequences:
        seq = list(seq)
        if seq == sorted(seq) and is_subsequence_of(seq,perm):
            increasing_sequences.append(seq)
    return increasing_sequences

