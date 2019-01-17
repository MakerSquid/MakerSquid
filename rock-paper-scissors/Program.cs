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
		private static Random rnd = new Random();

		static void Main(string[] args)
		{
			Play();
		}

		private static void Play()
		{
			var gameMove = GetMove();
			Console.WriteLine($"R ock  P aper  S cissors (I have chosen)               me {gameWins} wins, you {playerWins} wins");//{gameMove.ToString()}
			var playerMove = GetPlayerMove();
			GetWinner(playerMove, gameMove);


			if (playerMove == Moves.Quit)
			{
				Console.WriteLine("Thanks for playing!");
			}
			else
			{
				Play();
			}
		}

		private static Moves GetMove()
		{
			int move = rnd.Next(1, 4);

			return (Moves)move;
		}

		private static Moves GetPlayerMove()
		{
			var input = Console.ReadKey();
			Console.WriteLine("");

			if (input.Key == ConsoleKey.Q)
			{
				return Moves.Quit;
			}

			return EvalPlayerMove(input.Key);

		}

		private static Moves EvalPlayerMove(ConsoleKey input)
		{
			Moves result;

			switch(input)
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
					Console.WriteLine("Unexpected input. This game is void.");
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
					Console.WriteLine("Paper covers rock, I win!");
					outcome = true;
				}
				else if (game == Moves.Scissors)
				{
					Console.WriteLine("Rock smashes scissors, you win!");
					outcome = false;
				}
				else
				{
					Console.WriteLine("We tied!");
				}
			}
			if (player == Moves.Paper)
			{
				if (game == Moves.Scissors)
				{
					Console.WriteLine("Scissors cut paper, I win!");
					outcome = true;
				}
				else if (game == Moves.Rock)
				{
					Console.WriteLine("Paper covers rock, you win!");
					outcome = false;
				}
				else
				{
					Console.WriteLine("We tied!");
				}
			}
			if (player == Moves.Scissors)
			{
				if (game == Moves.Rock)
				{
					Console.WriteLine("Rock smashes scissors, I win!");
					outcome = true;
				}
				else if (game == Moves.Paper)
				{
					Console.WriteLine("Scissors cut paper, you win!");
					outcome = false;
				}
				else
				{
					Console.WriteLine("We tied!");
				}
			}

			if (outcome.HasValue && outcome.Value)
			{
				gameWins++;
			}
			else if(outcome.HasValue && !outcome.Value)
			{
				playerWins++;
			}
		}
	}
}
