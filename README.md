# Zid: Zen identifier

Zid stands for "Zen identifier".

A Zen identifier is a secure random id, similar to a random UUID (Universally Unique Identifier), with improvements to be faster, easier, more secure, and more sharable.

Zid specification:

  * Generated entirely by using a secure random generator.
  * You can use as many bits as you like, for example Zid128 is 128 bits.
  * The string representation is always hexadecimal lowecase: digits 0-9 and lowercase a-f.

See below for a comparison of Zid and UUID.

Website coming soon: <a href="http://zidplan.com">http://zidplan.com</a>

## Classes

If you're writing a Zid class, we suggest writing these methods:

  * `Zid.create`: generate a new Zid.
  * `Zid.validate(object)`: is an object a valid Zid?
  * `Zid.parse(object)`: parse an object to a new Zid.

## Language Implementations

Many programming languages have two kinds of random number generators: one kind is insecure, and one kind is secure. A Zen identifier must always use the secure random number generator.

Ruby:

  * Use SecureRandom, not rand.

Swift:

  * Use SecRandomCopyBytes, not arc4random

## Zid vs. UUID comparison

Zid128 is similar to a UUID-4.

Similarities:

  * Both are 128 bit.
  * Both contain randomness.
  * Both can be represented as hexadecimal lowercase strings.

Differences:

  * A Zid specification mandates secure randomness. The UUID spect does not.
  * A Zid is entirely random. UUID-4 has one piece that's not random, that shows the variant number.
  * A Zid string representation is entirely hexadecimal lowercase. A UUID string representation can use dashes, lowercase, uppercase.lowercase.
  * A Zid is specific. UUID-4 is one variant of the overall UUID specification.

To format an Zid in the style of a UUID canonical representation:

    zid = "90f44e35a062479289ff75ab2abc0ed3"
    zid.sub(/(.{8})(.{4})(.{4})(.{16})/,"#$1-#$2-#$3-#$4")
    #=> "90f44e35-a062-4792-89ff75ab2abc0ed3"

Note: the result string is formatted like a UUID, but is not guaranteed to be valid UUID. This is because the Zid is random, whereas the UUID specification requires a specific bit that indicates the UUID is random.

To format a UUID in the style of an Zid:

    uuid = "14fFE137-2DB2-4A37-A2A4-A04DB1C756CA"
    uuid.gsub(/-/,"").downcase
    #=> ""14f7e1372db24a37a2a4a04db1c756ca"

Note: the result string is formatted like a Zid, but is not a valid Zid. This is because there's no guarantee that the UUID was randomly generated using a secure random generator, and also because the UUID-4 specification requires a random UUID to set the third section's first digit to 4.


## Unix tooling

To generate an Zid on a typical Unix system, one way is the hexdump command:

    $ hexdump -n 16 -v -e '16/1 "%02x" "\n"' /dev/random
    b29dd48b7040f788fd926ebf1f4eddd0

To digest an Zid by using SHA256:

    $ echo -n "b29dd48b7040f788fd926ebf1f4eddd0" | shasum -a 256
    afdfb0400e479285040e541ee87d9227d5731a7232ecfa5a07074ee0ad171c64


## Database tooling

To store a Zid in a typical database, there are many ways.

For example, a Zid128 can be stored using any compatible field, such as:

  * A 128-bit field
  * A 32-character string
  * A 16-byte array
  * An unsigned integer 128

Some databases have specialize fields for 128 bit values, such as PostgreSQL and its UUID extensions. PostgreSQL states that a UUID field will accept a string that is lowercase and that omits dashes. PostgreSQL does not do any validity-checking on the UUID value. Thus it is viable to store an Zid in a UUID field. Our team has a goal to create a PostgreSQL extension for the Zid data type.

## Credits

* [Joel Parker Henderson](https://github.com/joelparkerhenderson)
* [Michael Pope](https://github.com/amorphid)

## Tracking

* Git: <https://github.com/joelparkerhenderosn/zid>
* Contact: Joel Parker Henderson, <joel@joelparkerhenderson.com>
