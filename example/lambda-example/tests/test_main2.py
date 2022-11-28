import unittest

class AnotherTesting(unittest.TestCase):
    def run(self, result = None):
        super(AnotherTesting, self).run(result)

    def test_another_string(self):
        a = 'some'
        b = 'some'
        self.assertEqual(a, b)

    def test_another_boolean(self):
        a = True
        b = True
        self.assertEqual(a, b)