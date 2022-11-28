import unittest

class Testing(unittest.TestCase):
    def run(self, result = None):
        super(Testing, self).run(result)

    def test_string(self):
        a = 'some'
        b = 'some'
        self.assertEqual(a, b)

    def test_boolean(self):
        a = True
        b = True
        self.assertEqual(a, b)