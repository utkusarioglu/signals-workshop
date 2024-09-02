from __future__ import annotations


class Scale:
    def __init__(self, index, degrees: tuple[int], tone_count: int) -> None:
        self.index = index
        self.degrees = degrees
        self.tone_count = tone_count
        self.intervals = self._toIntervals()

    def _toIntervals(self):
        if len(self.degrees) < 2:
            return self.degrees
        intervals = list(self.degrees[0:1])
        for i in range(1, len(self.degrees)):
            intervals.append(self.degrees[i] - self.degrees[i - 1])
        return tuple(intervals)

    def __len__(self):
        return len(self.degrees)


class Family:
    def __init__(self, top: Scale) -> None:
        self.top = top

    def getIntervals(self) -> tuple[tuple[int]]:
        curr = [
            *list(self.top.intervals),
            self.top.tone_count - self.top.degrees[-1] + 1,
        ]
        l = [self.top.intervals]
        size = len(self.top)
        for _ in range(size):
            new_row = [*curr[1:], curr[0]]
            curr = new_row
            l.append(tuple(new_row[:-1]))
        return tuple(l)

    def getDegrees(self) -> tuple[tuple[int]]:
        l = []
        for intervals in self.getIntervals():
            row = []
            for tone in intervals:
                curr = row[-1] if len(row) else 0
                row.append(curr + tone)
            l.append(tuple(row))
        return tuple(l)


class Tone:
    """A single tone in a scale
    Represents one of the intervals/degrees in a musical scale.

    Example:
    Consider the major scale in interval form: (2, 2, 1, 2, 2, 2)
    Any of the 2 or 1 values in the tuple is a tone.
    """

    def __init__(
        self, parent: Tone, pos: int, interval: int, degree: int
    ) -> None:
        self.parent = parent
        self.pos = pos
        self.interval = interval
        self.degree = degree
        self.next = set()

    def addNext(self, node: Tone):
        """Add the next tone in the scale"""
        degree_node = self.getByDegree(node.degree)
        interval_node = self.getByInterval(node.interval)
        if degree_node == interval_node and degree_node is not None:
            return degree_node
        self.next.add(node)
        return node

    def getByInterval(self, interval: int):
        """Returns the first child that matches the interval value.
        In a proper implementation, there should be only one such node
        that could be returned
        """
        for node in self.next:
            if node.interval == interval:
                return node
        return None

    def getByDegree(self, degree: int):
        """Returns the first child that matches the degree value.
        In a proper implementation, there should be only one such node
        that could be returned
        """
        for node in self.next:
            if node.degree == degree:
                return node
        return None

    def setIndex(self, index: int):
        """Sets the index for the scale
        Index represents the scale's position in scales map.

        Example: For major mode this value would be 336.
        """
        assert len(self.next) == 0, AssertionError(
            f"Index cannot be defined if the node is not a leaf: {len(self.next)}"
        )
        self.index = index
