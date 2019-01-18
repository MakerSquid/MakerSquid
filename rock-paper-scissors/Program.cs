using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace rock_paper_scissors
{
	class Program
	{
		private enum Moves
		{
			Rock = 1,
			Paper = 2,
			Scissors = 3,
			Void = 4,
			Quit = 5
		}
		private static int playerWins = 0;
		private static int gameWins = 0;
		private static Random rnd;
		private static bool cheat = false;
		private static bool randomize = false;
		private static bool reportChunks = false;
		private static int games = 0;
		private static int maxGames = 7;

		static void Main(string[] args)
		{
			try
			{
				rnd = new Random();
				if (args.Length > 0)
				{
					if (args[0] == "-c")
					{
						cheat = true;
					}

					if (args[0] == "-r")
					{
						randomize = true;
						maxGames = 1000000;

						if (maxGames >= 100000000)
						{
							reportChunks = true;
						}
					}
				}
				var keepGoing = true;
				while (games <= maxGames && keepGoing)
				{
					keepGoing = Play();
				}
				if (randomize)
				{
					Console.WriteLine($"me {gameWins} wins, you {playerWins} wins ({games - gameWins - playerWins})");
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
		}

		private static bool Play()
		{
			Moves gameMove = GetMove();
			var cheating = "";
			if (cheat)
			{
				cheating = $" {gameMove.ToString()}";
			}
			if (!randomize)
			{
				SendOutput($"R ock  P aper  S cissors (I have chosen{cheating})               me {gameWins} wins, you {playerWins} wins");
			}
			Moves playerMove = GetPlayerMove();
			GetWinner(playerMove, gameMove);


			if (playerMove != Moves.Quit)
			{
				if (reportChunks)
				{
					if (games % (maxGames / 10) == 0)
					{
						Console.WriteLine(games);
					}
				}
				games++;
			}
			else
			{
				return false;
			}

			return true;
		}

		private static Moves GetMove()
		{
			return (Moves)rnd.Next(1, 4);
		}

		private static Moves GetPlayerMove()
		{
			if (randomize)
			{
				return GetMove();
			}

			var input = Console.ReadKey();
			SendOutput("");

			if (input.Key == ConsoleKey.Q)
			{
				return Moves.Quit;
			}

			return EvalPlayerMove(input.Key);

		}

		private static void SendOutput(string message)
		{
			if (!randomize)
			{
				Console.WriteLine(message);
			}
		}

		private static Moves EvalPlayerMove(ConsoleKey input)
		{
			Moves result;

			switch (input)
			{
				case ConsoleKey.R:
					{
						result = Moves.Rock;
						break;
					}
				case ConsoleKey.P:
					{
						result = Moves.Paper;
						break;
					}
				case ConsoleKey.S:
					{
						result = Moves.Scissors;
						break;
					}
				default:
					{
						SendOutput("Unexpected input. This game is void.");
						result = Moves.Void;
						break;
					}
			}

			return result;
		}

		private static void GetWinner(Moves player, Moves game)
		{
			bool? outcome = null;

			if (player == Moves.Rock)
			{
				if (game == Moves.Paper)
				{
					SendOutput("Paper covers rock, I win!");
					outcome = true;
				}
				else if (game == Moves.Scissors)
				{
					SendOutput("Rock smashes scissors, you win!");
					outcome = false;
				}
				else
				{
					SendOutput("We tied!");
				}
			}
			if (player == Moves.Paper)
			{
				if (game == Moves.Scissors)
				{
					SendOutput("Scissors cut paper, I win!");
					outcome = true;
				}
				else if (game == Moves.Rock)
				{
					SendOutput("Paper covers rock, you win!");
					outcome = false;
				}
				else
				{
					SendOutput("We tied!");
				}
			}
			if (player == Moves.Scissors)
			{
				if (game == Moves.Rock)
				{
					SendOutput("Rock smashes scissors, I win!");
					outcome = true;
				}
				else if (game == Moves.Paper)
				{
					SendOutput("Scissors cut paper, you win!");
					outcome = false;
				}
				else
				{
					SendOutput("We tied!");
				}
			}

			if (outcome.HasValue && outcome.Value)
			{
				gameWins++;
			}
			else if (outcome.HasValue && !outcome.Value)
			{
				playerWins++;
			}
		}
	}
}
