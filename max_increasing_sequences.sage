def longest_increasing_subsequences(self):
    r"""
    Return the list of the longest increasing subsequences of ``self``
    
    A theorem of Schensted ([Sch1960]) states that an increasing
    subsequence of length `i` ends with the value entered in the `i`-th
    column of the p-tableau. The algorithm records which column of the
    p-tableau each value of the permutation is entered into, and
    computes all possible combinations of one entry from each column.
    The algorithm then checks if the combination is an increasing
    sequence.
    
    EXAMPLES::

            sage: Permutation([2,3,4,1]).longest_increasing_subsequences()
            [[2, 3, 4]]
            sage: Permutation([5, 7, 1, 2, 6, 4, 3]).longest_increasing_subsequences()
            [[1, 2, 6], [1, 2, 4], [1, 2, 3]]
    """

    
    
    def is_subsequence_of(seq1, self):
        r"""
        Returns whether seq1 is a subsequence of permutation `self`
        """
        
        j = 0
        seq2 = []
        while j<len(seq1)-1:
            if self.index(seq1[j]) < self.index(seq1[j+1]):
                j = j+1
            else:
                return False
        return True


    n = self.size()
    
    # getting the column in which each element is inserted
    first_row_p_tableau = []
    column = []
    for i in range(n):
        inserted = False
        j = 0  # j is j-th column of p-tableau
        while j < len(first_row_p_tableau) and not inserted:
            if first_row_p_tableau[j] > self[i]:
                first_row_p_tableau[j] = self[i]
                column.append(j)
                inserted = True
            j = j+1
        if not inserted:
            first_row_p_tableau.append(self[i])
            column.append(j)
            
    # getting the sets for columns
    s = [[] for i in range(len(first_row_p_tableau))]
    for i in range(n):
        s[column[i]].append(self[i])
    increasing_sequences = []
    
    # getting the increasing sequences
    import itertools
    potential_sequences = list(itertools.product(*s))
    for seq in potential_sequences:
        seq = list(seq)
        if seq == sorted(seq) and is_subsequence_of(seq, self):
            increasing_sequences.append(seq)
    return increasing_sequences

